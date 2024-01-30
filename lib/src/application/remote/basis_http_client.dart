import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BasisHttpClient extends http.BaseClient with AuthHeaders {
  late String urlBase;

  BasisHttpClient(String urlBase) {
    this.urlBase = urlBase;
  }

  String? _authorizationToken;

  void setAuthorizationToken(String? authorizationToken) {
    _authorizationToken = authorizationToken;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      return await request.send().timeout(const Duration(seconds: 45));
    } on SocketException catch (e) {
      throw SocketException(
        e.message,
        osError: e.osError,
        address: e.address,
      );
    }
  }

  Future<http.Response> httpGET(
    String path, {
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    return await super.get(
      Uri.parse('${String.fromEnvironment(urlBase)}/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
      ),
    );
  }

  Future<http.Response> httpPUT(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
    bool defaultHeaders = true,
  }) async {
    return await super.put(
      Uri.parse('${String.fromEnvironment(urlBase)}/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
        defaultHeaders,
      ),
      body: defaultHeaders && body != null ? jsonEncode(body) : body,
      encoding: encoding,
    );
  }

  Future<http.Response> httpPOST(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
    bool setDefaultHeaders = true,
  }) async {
    return await super.post(
      Uri.parse('${String.fromEnvironment(urlBase)}/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
        setDefaultHeaders,
      ),
      body: setDefaultHeaders ? jsonEncode(body) : body,
      encoding: encoding,
    );
  }

  Future<http.Response> httpDELETE(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
    bool setDefaultHeaders = true,
  }) async {
    return await super.delete(
      Uri.parse('${String.fromEnvironment(urlBase)}/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
        setDefaultHeaders,
      ),
      body: setDefaultHeaders ? jsonEncode(body) : body,
      encoding: encoding,
    );
  }

  Future<http.Response> httpUPLOAD(
    String path, {
    required String fileName,
    required String filePath,
    Map<String, String>? headers,
    bool requireAuth = false,
    bool setDefaultHeaders = true,
  }) async {
    final multipartRequest =
        http.MultipartRequest('POST', Uri.parse('${String.fromEnvironment(urlBase)}/$path'))
          ..headers.addAll(
              authorize(requireAuth, headers ?? _headers,
              _authorizationToken, setDefaultHeaders,
            ),
          )
          ..files.add(
            await http.MultipartFile.fromPath(
              fileName,
              filePath,
            ),
          );
    final streamResponse = await multipartRequest.send();
    final asList = await streamResponse.stream.toList();

    return http.Response(
      utf8.decode(asList.first),
      streamResponse.statusCode,
      reasonPhrase: streamResponse.reasonPhrase,
    );
  }

  Future<http.Response> httpFormaDataPOST(
    String path, {
    required Map<String, String> files,
    required Map<String, String> body,
    Map<String, String>? headers,
    bool requireAuth = false,
    bool setDefaultHeaders = true,
  }) async {
    final multipartRequest =
        http.MultipartRequest('POST', Uri.parse('${String.fromEnvironment(urlBase)}/$path'))
          ..headers.addAll(authorize(
            requireAuth,
            headers ?? _headers,
            _authorizationToken,
            setDefaultHeaders,
          ))
          ..fields.addAll(body)
          ..files.add(
            await http.MultipartFile.fromPath(
              files.entries.first.key,
              files.entries.first.value,
            ),
          );
    final streamResponse = await multipartRequest.send();
    final asList = await streamResponse.stream.toList();

    return http.Response(
      utf8.decode(asList.first),
      streamResponse.statusCode,
      reasonPhrase: streamResponse.reasonPhrase,
    );
  }
}

mixin AuthHeaders {
  final _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> authorize(
    bool requireAuth,
    Map<String, String> headers,
    String? authorizationToken, [
      bool setDefaultHeaders = true,
    ]
  ) {
    if (!setDefaultHeaders) _headers.clear();
    if (requireAuth) {
      headers.addAll({'Authorization': 'Bearer ${authorizationToken ?? ''}'});
    }

    return headers;
  }
}