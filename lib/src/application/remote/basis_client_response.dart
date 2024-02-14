import 'package:equatable/equatable.dart';

class BasisClientResponse<T> extends Equatable {
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  final bool success;

  const BasisClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.success = false,
  });

  @override
  List<Object?> get props => [data, statusCode, statusMessage, success];
}
