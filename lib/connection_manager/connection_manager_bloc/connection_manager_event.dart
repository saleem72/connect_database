// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'connection_manager_bloc.dart';

@immutable
abstract class ConnectionManagerEvent {}

class ConnectionManagerHostHasChange extends ConnectionManagerEvent {
  final String host;

  ConnectionManagerHostHasChange({
    required this.host,
  });
}

class ConnectionManagerPortHasChange extends ConnectionManagerEvent {
  final String port;

  ConnectionManagerPortHasChange({
    required this.port,
  });
}

class ConnectionManagerDatabaseHasChange extends ConnectionManagerEvent {
  final String database;

  ConnectionManagerDatabaseHasChange({
    required this.database,
  });
}

class ConnectionManagerUsernameHasChange extends ConnectionManagerEvent {
  final String username;

  ConnectionManagerUsernameHasChange({
    required this.username,
  });
}

class ConnectionManagerPasswordHasChange extends ConnectionManagerEvent {
  final String password;

  ConnectionManagerPasswordHasChange({
    required this.password,
  });
}

class ConnectionManagerQueryHasChange extends ConnectionManagerEvent {
  final String query;

  ConnectionManagerQueryHasChange({
    required this.query,
  });
}

class ConnectionManagerConnect extends ConnectionManagerEvent {}

class ConnectionManagerIsolatedConnect extends ConnectionManagerEvent {}
