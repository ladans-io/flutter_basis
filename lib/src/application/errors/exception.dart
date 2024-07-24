import 'dart:io';

import 'package:equatable/equatable.dart';

const invalidCredentials = 'Invalid credentials.';
const invalidParameters = 'Dados inválidos.';
const notFound = 'Path supported yet.';
const cacheException = 'No cached content found.';
const internalProcessingError = 'Internal processing error.';
const errorReceivingData = 'Error receiving data.';
const serverNotFound = 'Server not found! Please, check your connection and try again.';
const unknownError = 'Unknown error.';
const requestTimeout = 'Request timed out. Please try again later.';

String formatMessage(String message) {
  bool contains(String err) => message.contains(err);
  if (contains('Failed host lookup')) return serverNotFound;
  if (contains('Server Error')) return internalProcessingError;
  if (contains('Connection closed while receiving data')) return errorReceivingData;
  if (contains('Unauthorized')) return invalidCredentials;
  if (contains('Undefined')) return invalidParameters;
  if (contains('The operation has timed out') || 
      contains('Timeout during reading') ||
      contains('TimeoutException')
  ) {
    return requestTimeout;
  }
  if (contains('Name or service not known')) return unknownError;
  if (contains('Connection closed while receiving data')) return errorReceivingData;

  return message;
}

/// [BasisException]
abstract class BasisException extends Equatable {
  final Object exception;
  const BasisException(this.exception);
}

/// [BasisClientException]
abstract class BasisClientException extends Equatable {
  final String? message;
  final int? statusCode;
  const BasisClientException({this.message, this.statusCode});

  String get formattedMessage => formatMessage(message!);
}

/// [CommonException]
class CommonException extends BasisException {
  const CommonException(exception) : super(exception);

  @override
  List<Object> get props => [exception];
}

/// [BasisCacheException]
class BasisCacheException extends BasisException {
  const BasisCacheException(exception) : super(exception);

  @override
  List<Object> get props => [exception];
}

/// [ClientRequestException]
class ClientRequestException extends BasisClientException {
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

  String get formattedMessage => formatMessage(message);
}

/// [DomainException]
class DomainException extends BasisException {
  const DomainException(message) : super(message);

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'Domain exception:\n$exception';
  }
}

/// [UnexpectedValueException]
///
class UnexpectedValueException extends BasisException {
  const UnexpectedValueException(super.message);

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'Value exception:\n$exception';
  }
}
