//

// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    required this.message,
  });

  final String message;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}
