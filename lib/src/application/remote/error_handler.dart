import 'dart:convert';

import 'package:http/http.dart';

import '../errors/exception.dart';

mixin ErrorHandler {
  String _handleMap(Map value, int _) {
    if (value['erro'] != null) return value['erro'];

    return unknownError;
  }

  String? handleError(Response response) {
    if (!_hasHtmlParse(response)) {
      try {
        final value = json.decode(response.body);
        if (value is Map) return _handleMap(value, response.statusCode);

        final valueStr = value.toString();
        if (_isIOClient(valueStr)) {
          throw ClientRequestException(
            message: errorReceivingData,
            statusCode: response.statusCode,
          );
        }

        return valueStr;
      } catch (e) {
        throw ClientRequestException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } else if (_hasHtmlParse(response)) {
      throw ClientRequestException(
        message: unknownError,
        statusCode: response.statusCode,
      );
    } else {
      throw ClientRequestException(
        message: response.body.replaceAll(r'\"', ''),
        statusCode: response.statusCode,
      );
    }
  }

  bool _hasHtmlParse(Response response) {
    final bodyLwr = response.body.toLowerCase();

    return bodyLwr.contains('<!doctype html>') || bodyLwr.contains('<html>');
  }

  bool _isIOClient(String value) => value.toLowerCase().contains('ioclient.send');
}
