import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object> get props => [message, code ?? 0];
}

/// [ServerFailure]
///
class ServerFailure extends Failure {
  const ServerFailure({final message, final error, final code})
      : super(message: message, code: code);
}

/// [CommonFailure]
///
class CommonFailure extends Failure {
  const CommonFailure({required final message})
      : super(message: message);
}

/// [CacheFailure]
///
class CacheFailure extends Failure {
  const CacheFailure({final message}) : super(message: message);
}
