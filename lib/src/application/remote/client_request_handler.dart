import 'package:http/http.dart';

import '../errors/exception.dart';
import 'error_handler.dart';

abstract class ClientRequestHandler with ErrorHandler {
  Response handleClientRequest(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        if (response.body.isNotEmpty || response.statusCode == 204) {
          return response;
        } else {
          throw ClientRequestException(
            message: unknownError,
            statusCode: response.statusCode,
          );
        }
      case 400:
        throw ClientRequestException(
          message: handleError(response),
          statusCode: response.statusCode,
        );
      case 401:
      case 403:
        throw ClientRequestException(
          message: response.body.isEmpty
              ? invalidCredentials
              : handleError(response) ?? notFound,
          statusCode: response.statusCode,
        );
      case 404:
        throw ClientRequestException(
          message: response.body.isEmpty
              ? notFound
              : handleError(response) ?? notFound,
          statusCode: response.statusCode,
        );
      case 422:
        throw ClientRequestException(
          message: handleError(response),
          statusCode: response.statusCode,
        );
      default:
        throw ClientRequestException(
          message: handleError(response) ?? unknownError,
          statusCode: response.statusCode,
        );
    }
  }
}
