// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'connection_manager_bloc.dart';

@immutable
abstract class ConnectionManagerState {}

class ConnectionManagerInitial extends ConnectionManagerState {}

class ConnectionManagerLoading extends ConnectionManagerState {}

class ConnectionManagerFailure extends ConnectionManagerState {
  final Failure failure;
  ConnectionManagerFailure({
    required this.failure,
  });
}

class ConnectionManagerSuccess extends ConnectionManagerState {
  final List<Map<String, String>> records;

  ConnectionManagerSuccess({
    required this.records,
  });
}
