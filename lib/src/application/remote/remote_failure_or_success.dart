import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/bytes_to_file.dart';
import '../errors/exports.dart';
import 'client_response.dart';
import 'client_request_handler.dart';

typedef ClientRemoteCall = Future<http.Response>;

abstract class ClientEitherResponseHandler extends ClientRequestHandler {
  Future<(Failure?, ClientResponse?)> handleClientEitherResponse<T>(
    ClientRemoteCall call, {
      bool downloadFile = false,
    }
  ) async {
    try {
      final result = handleClientRequest(await call);

      return (
        null,
        ClientResponse(
          data: downloadFile 
            ? await bytesToFile(result.bodyBytes) 
            : switch(result.statusCode) {
                204 => 'Sucesso',
                _ => jsonDecode(result.body)
              },
          statusCode: result.statusCode,
          statusMessage: result.reasonPhrase,
        ),
      );
    } on ClientException catch (e) {
      return (ServerFailure(message: e.formattedMessage, code: e.statusCode), null);
    } on http.ClientException catch (e) {
      return (ServerFailure(message: getFormattedMessage(e.message), code: 0), null);
    } on BasisSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } on TimeoutException {
      return (const CommonFailure(message: requestTimeout), null);
    } catch (e) {
      return (CommonFailure(message: e.toString()), null);
    }
  }
}
