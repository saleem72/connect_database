//

import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:dartz/dartz.dart';

import '../failure/failure.dart';
import 'models/connection_params.dart';

class ConnectionHelper {
  // static const platform = MethodChannel('coders.com/connect_database');

  static Future<Either<Failure, List<Map<String, String>>>> connect({
    required String query,
    required ConnectionParams params,
  }) async {
    ReceivePort receivePort = ReceivePort();

    final Map<String, String> arguments = <String, String>{
      'host': params.host,
      'port': params.port,
      'database': params.database,
      'username': params.username,
      'password': params.password,
      'query': query
    };

    final isolate =
        await Isolate.spawn(executeSql, [receivePort.sendPort, arguments]);
    final isolateResult = await receivePort.first;

    isolate.kill(priority: Isolate.immediate);
    if (isolateResult is List<Map<String, String>>) {
      return Right(isolateResult);
    } else if (isolateResult is Failure) {
      return Left(isolateResult);
    } else {
      return const Left(Failure(message: 'Cannot reach the data'));
    }
  }

  static Future executeSql(List<dynamic> values) async {
    // const MethodChannel channel = MethodChannel('coders.com/connect_database');
    SendPort sendPort = values[0];
    MethodChannel platform = values[1];
    Map<String, String> arguments = values[2];

    try {
      List<dynamic>? methodResult = <dynamic>[];
      methodResult = await platform.invokeMethod<List<dynamic>>(
          'executeSQLStatement', arguments);

      if (methodResult != null) {
        // return Right(_decodeResult(methodResult));
        sendPort.send(_decodeResult(methodResult));
      } else {
        // return const Right([]);
        sendPort.send(const <Map<String, String>>[]);
      }
    } on PlatformException catch (e) {
      sendPort.send(Failure(message: e.message ?? ''));
    } catch (error) {
      sendPort.send(Failure(message: error.toString()));
    }
  }

  static List<Map<String, String>> _decodeResult(List<dynamic>? result) {
    if (result != null) {
      final outcome =
          result.map((record) => Map<String, dynamic>.from(record)).toList();
      final other = outcome.map((e) {
        return e.map((key, value) => MapEntry(key, value?.toString() ?? ''));
      }).toList();
      return other;
    }
    return <Map<String, String>>[];
  }
}
