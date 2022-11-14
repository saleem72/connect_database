//

enum ConnectionManagerTextFieldType {
  host,
  port,
  database,
  username,
  password,
  query
}

extension ConnectionManagerTextFieldTypeDetails
    on ConnectionManagerTextFieldType {
  String get label {
    switch (this) {
      case ConnectionManagerTextFieldType.host:
        return 'Host';
      case ConnectionManagerTextFieldType.port:
        return 'Port';
      case ConnectionManagerTextFieldType.database:
        return 'Database';
      case ConnectionManagerTextFieldType.username:
        return 'Username';
      case ConnectionManagerTextFieldType.password:
        return 'Password';
      case ConnectionManagerTextFieldType.query:
        return 'Query';
    }
  }
}
