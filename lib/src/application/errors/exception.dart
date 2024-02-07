import 'dart:io';

import 'package:equatable/equatable.dart';

const internalProcessingError = 'Ocorreu um erro de processamento interno.';
const errorReceivingData = 'Falha ao receber os dados.';
const unknownError = 'Ocorreu um erro desconhecido.';
const invalidCredentials = 'E-mail ou senha incorretos.';
const invalidParameters = 'Dados inválidos.';
const notFound = 'Funcionalidade indisponível no momento.';
const requestTimeout = 'Sem resposta do servidor.';
const cacheException = 'No momento, não encontramos nenhum registro correspondente.';

/// [Exception]
abstract class Exception extends Equatable {
  final Object exception;
  const Exception(this.exception);
}

/// [ClientException]
abstract class ClientException extends Equatable {
  final String? message;
  final int? statusCode;
  const ClientException({this.message, this.statusCode});

  String get formattedMessage {
    bool contains(String err) => message!.contains(err);

    if (contains('Unauthorized')) return invalidCredentials;

    if (contains('Undefined')) return invalidParameters;

    if (contains('The operation has timed out') || contains('Timeout during reading')) {
      return requestTimeout;
    }

    if (contains('Server Error')) {
      return internalProcessingError;
    }

    if (contains('Name or service not known')) return unknownError;

    return message!;
  }
}

/// [CommonException]
class CommonException extends Exception {
  const CommonException(exception) : super(exception);

  @override
  List<Object> get props => [exception];
}

/// [CacheException]
class CacheException extends Exception {
  const CacheException(exception) : super(exception);

  @override
  List<Object> get props => [exception];
}

/// [ClientRequestException]
class ClientRequestException extends ClientException {
  const ClientRequestException({
    final String? message,
    final int? statusCode,
  }) : super(message: message, statusCode: statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

/// [BasisSocketException]
class BasisSocketException extends SocketException {
  const BasisSocketException(
    String message, {
    OSError? osError,
    InternetAddress? address,
  }) : super(message, osError: osError, address: address);

  String get formattedMessage {
    if (message.contains('Failed host lookup')) {
      return "Host ${message.split(':')[1]} não foi encontrado";
    }

    return message;
  }
}

/// [DomainException]
class DomainException extends Exception {
  const DomainException(message) : super(message);

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'EXCEÇÃO DE DOMÍNIO\n$exception';
  }
}

/// [UnexpectedValueException]
///
class UnexpectedValueException extends Exception {
  const UnexpectedValueException(super.message);

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'EXCEÇÃO DE VALOR\n$exception';
  }
}
