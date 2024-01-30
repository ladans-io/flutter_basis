import 'package:equatable/equatable.dart';

class ClientResponse<T> extends Equatable {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  final bool success;

  const ClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.success = false,
  });

  @override
  List<Object?> get props => [data, statusCode, statusMessage, success];
}
