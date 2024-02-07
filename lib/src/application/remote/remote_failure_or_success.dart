import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' hide ClientException;

import '../../utils/bytes_to_file.dart';
import '../errors/exports.dart';
import 'client_response.dart';
import 'client_request_handler.dart';

typedef TypeRemoteCall = Future<Response>;

abstract class RemoteFailureOrSuccess extends ClientRequestHandler {
  Future<(Failure?, ClientResponse?)> onRemoteFailureOrSuccess<T>(
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
    } on BasisSocketException catch (e) {
      return (CommonFailure(message: e.formattedMessage), null);
    } on TimeoutException {
      return (const CommonFailure(message: requestTimeout), null);
    } catch (e) {
      return (CommonFailure(message: e.toString()), null);
    }
  }

  @Deprecated('Esta função será removida em breve, favor fazer o uso de [onRemoteFailureOrSuccess]')
  Future<Either<Failure, ClientResponse>> onRemoteEither(
    TypeRemoteCall call, {
      bool downloadFile = false,
    }
  ) async {
    try {
      final handleResult = handleRequest(await call);

      return Right(
        ClientResponse(
          data: downloadFile 
            ? await bytesToFile(handleResult.bodyBytes)
            : jsonDecode(handleResult.body), 
          statusCode: handleResult.statusCode, 
          statusMessage: handleResult.reasonPhrase,
          success: handleResult.statusCode == 200,
        ),
      );

    } on ClientException catch (e) {
      return Left(ServerFailure(message: e.formattedMessage, code: e.statusCode));
    } on BasisSocketException catch (e) {
      return Left(CommonFailure(message: e.formattedMessage));
    } on TimeoutException {
      return const Left(CommonFailure(message: requestTimeout));
    } catch (e, s) {
      return Left(CommonFailure(message: s.toString()));
    }
  }
}
