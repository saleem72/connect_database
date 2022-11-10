//

import 'dart:convert';

class ConnectionParams {
  final String host;
  final String port;
  final String database;
  final String username;
  final String password;
  final String query;

  ConnectionParams({
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
    required this.query,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'host': host,
      'port': port,
      'database': database,
      'username': username,
      'password': password,
      'query': query,
    };
  }

  factory ConnectionParams.fromMap(Map<String, dynamic> map) {
    return ConnectionParams(
      host: map['host'] as String,
      port: map['port'] as String,
      database: map['database'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      query: map['query'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionParams.fromJson(String source) =>
      ConnectionParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
