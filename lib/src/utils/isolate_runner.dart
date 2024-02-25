import 'package:flutter/foundation.dart';

/// Usage example:
///
/// await runIsolate<RequestResponse?, MappedDataResult?>(
///     message,
///     (e) => return MappedDataResult.fromJson(e['data']),
/// );
Future<T?> runIsolate<E, T>(
  E message,
  T? Function(E) callback,
) async => await compute<E, T?>(callback, message);

