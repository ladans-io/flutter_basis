import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/bytes_to_file.dart';
import '../errors/exports.dart';
import 'basis_client_response.dart';
import 'client_request_handler.dart';

typedef ClientRemoteCall = Future<http.Response>;

abstract class ClientEitherResponseHandler extends ClientRequestHandler {
  Future<(Failure?, BasisClientResponse?)> handleClientEitherResponse<T>(
    ClientRemoteCall call, {
      bool downloadFile = false,
      String? fileExtension,
      Function(Object)? onCatch,
      Function()? onTry,
      Function()? onFinally,
    }
  ) async {
    try {
      if (onTry != null) onTry();

      final result = handleClientRequest(await call);

      return (
        null,
        BasisClientResponse(
          data: downloadFile 
            ? await bytesToFile(data: result.bodyBytes, extension: fileExtension ?? 'pdf')
            : switch(result.statusCode) { 204 => 'Sucesso', _ => jsonDecode(result.body) },
          statusCode: result.statusCode,
          statusMessage: result.reasonPhrase,
        ),
      );
    } on BasisClientException catch (e) {
      return (ServerFailure(message: e.formattedMessage, code: e.statusCode), null);
    } on http.ClientException catch (e) {
      return (ServerFailure(message: formatMessage(e.message), code: 0), null);
    } on BasisSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } on TimeoutException {
      return (const CommonFailure(message: requestTimeout), null);
    } catch (e) {
      if (onCatch != null) onCatch(e);

      return (CommonFailure(message: e.toString()), null);
    } finally {
      if (onFinally != null) onFinally();
    }
  }
}
