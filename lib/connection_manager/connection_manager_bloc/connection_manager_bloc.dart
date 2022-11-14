// ignore_for_file: depend_on_referenced_packages, invalid_use_of_visible_for_testing_member

import 'dart:isolate';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:connect_database/connection_manager/connection_manager.dart';
import 'package:connect_database/failure/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../connection_helper.dart';
import '../models/connection_params.dart';

part 'connection_manager_event.dart';
part 'connection_manager_state.dart';

class ConnectionManagerBloc
    extends Bloc<ConnectionManagerEvent, ConnectionManagerState> {
  String host;
  String port;
  String database;
  String username;
  String password;
  String query;

  static const platform = MethodChannel('coders.com/connect_database');

  final ConnectionManager _connectionManager;

  ConnectionManagerBloc({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
    required this.query,
    required ConnectionManager connectionManager,
  })  : _connectionManager = connectionManager,
        super(ConnectionManagerInitial()) {
    on<ConnectionManagerEvent>((event, emit) {
      if (event is ConnectionManagerHostHasChange) {
        host = event.host;
      }

      if (event is ConnectionManagerPortHasChange) {
        port = event.port;
      }

      if (event is ConnectionManagerDatabaseHasChange) {
        database = event.database;
      }

      if (event is ConnectionManagerUsernameHasChange) {
        username = event.username;
      }

      if (event is ConnectionManagerPasswordHasChange) {
        password = event.password;
      }

      if (event is ConnectionManagerQueryHasChange) {
        query = event.query;
      }

      if (event is ConnectionManagerConnect) {
        _connet();
      }

      if (event is ConnectionManagerIsolatedConnect) {
        _anotherConnet();
      }
    });
  }

  void _connet() async {
    if (query.isEmpty) {
      emit(ConnectionManagerFailure(
          failure: const Failure(message: 'Put some statment')));
      return;
    }
    emit(ConnectionManagerLoading());

    final params = ConnectionParams(
      host: host,
      port: port,
      database: database,
      username: username,
      password: password,
      query: query,
    );
    final result =
        await _connectionManager.connect(query: query, params: params);
    result.fold(
      (failure) {
        emit(ConnectionManagerFailure(failure: failure));
      },
      (records) {
        emit(ConnectionManagerSuccess(records: records));
      },
    );
  }

  void _anotherConnet() async {
    if (query.isEmpty) {
      emit(ConnectionManagerFailure(
          failure: const Failure(message: 'Put some statment')));
      return;
    }
    emit(ConnectionManagerLoading());

    final params = ConnectionParams(
      host: host,
      port: port,
      database: database,
      username: username,
      password: password,
      query: query,
    );

    ReceivePort receivePort = ReceivePort();

    final Map<String, String> arguments = <String, String>{
      'host': params.host,
      'port': params.port,
      'database': params.database,
      'username': params.username,
      'password': params.password,
      'query': query
    };
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    final isolate = await Isolate.spawn(
      ConnectionHelper.executeSql,
      [receivePort.sendPort, platform, arguments],
    );

    final isolateResult = await receivePort.first;

    isolate.kill(priority: Isolate.immediate);
    if (isolateResult is List<Map<String, String>>) {
      emit(ConnectionManagerSuccess(records: isolateResult));
    } else if (isolateResult is Failure) {
      print(isolateResult.message);
      emit(ConnectionManagerFailure(failure: isolateResult));
    } else {
      emit(ConnectionManagerFailure(
          failure: const Failure(message: 'Cannot reach the data')));
    }
  }
}
