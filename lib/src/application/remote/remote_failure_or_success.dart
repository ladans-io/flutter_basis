import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' hide ClientException;

import '../errors/exports.dart';
import 'client_response.dart';
import 'client_request_handler.dart';

typedef TypeRemoteCall = Future<Response>;

abstract class RemoteFailureOrSuccess extends ClientRequestHandler {
  Future<(Failure?, ClientResponse?)> getRemoteFailureOrSuccess<T>(
    TypeRemoteCall call,
  ) async {
    try {
      final result = handleRequest(await call);

      return (
        null,
        ClientResponse(
          data: switch(result.statusCode) {
            204 => 'Sucesso',
            _ => jsonDecode(result.body)
          },
          statusCode: result.statusCode,
          statusMessage: result.reasonPhrase,
        ),
      );
    } on ClientException catch (e) {
      return (
        ServerFailure(message: e.formattedMessage, code: e.statusCode),
        null
      );
    } on DshSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } on TimeoutException {
      return (const CommonFailure(message: requestTimeout), null);
    } catch (e) {
      return (CommonFailure(message: e.toString()), null);
    }
  }
}
