import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../errors/exports.dart';

// ignore_for_file: non_constant_identifier_names
class BasisHttpClient extends http.BaseClient with AuthHeaders {
  late String urlBase;

  BasisHttpClient({String? urlBase}) {
    this.urlBase = urlBase ?? String.fromEnvironment('URL_BASE');
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
      throw BasisSocketException(
        e.message,
        osError: e.osError,
        address: e.address,
      );
    }
  }

  Future<http.Response> GET(
    String path, {
    Map<String, String>? headers,
    bool requireAuth = false,
  }) async {
    return await super.get(
      Uri.parse('$urlBase/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
      ),
    );
  }

  Future<http.Response> PUT(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
    bool isCustomHeaders = false,
  }) async {
    return await super.put(
      Uri.parse('$urlBase/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
        isCustomHeaders,
      ),
      body: !isCustomHeaders && body != null ? jsonEncode(body) : body,
      encoding: encoding,
    );
  }

  Future<http.Response> POST(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
    bool isCustomHeaders = false,
  }) async {
    return await super.post(
      Uri.parse('$urlBase/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
        isCustomHeaders,
      ),
      body: !isCustomHeaders ? jsonEncode(body) : body,
      encoding: encoding,
    );
  }

  Future<http.Response> DELETE(
    String path, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    bool requireAuth = false,
    bool isCustomHeaders = false,
  }) async {
    return await super.delete(
      Uri.parse('$urlBase/$path'),
      headers: authorize(
        requireAuth,
        headers ?? _headers,
        _authorizationToken,
        isCustomHeaders,
      ),
      body: !isCustomHeaders ? jsonEncode(body) : body,
      encoding: encoding,
    );
  }

  Future<http.Response> UPLOAD(
    String path, {
    required String fileName,
    required String filePath,
    Map<String, String>? headers,
    bool requireAuth = false,
    bool isCustomHeaders = false,
  }) async {
    final multipartRequest =
        http.MultipartRequest('POST', Uri.parse('$urlBase/$path'))
          ..headers.addAll(
              authorize(requireAuth, headers ?? _headers,
              _authorizationToken, isCustomHeaders,
            ),
          )
          ..files.add(await http.MultipartFile.fromPath(fileName, filePath));

    return await http.Response.fromStream(await multipartRequest.send());
  }

  Future<http.Response> FORM_DATA_POST(
    String path, {
    required Map<String, String> files,
    required Map<String, String> body,
    Map<String, String>? headers,
    bool requireAuth = false,
    bool isCustomHeaders = false,
  }) async {
    final multipartRequest =
        http.MultipartRequest('POST', Uri.parse('$urlBase/$path'))
          ..headers.addAll(authorize(
            requireAuth,
            headers ?? _headers,
            _authorizationToken,
            isCustomHeaders,
          ))
          ..fields.addAll(body)
          ..files.add(
            await http.MultipartFile.fromPath(
              files.entries.first.key,
              files.entries.first.value,
            ),
          );

    return await http.Response.fromStream(await multipartRequest.send());
  }
}

mixin AuthHeaders {
  final _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Mobile Safari/537.36',
  };

  Map<String, String> authorize(
    bool requireAuth,
    Map<String, String> headers,
    String? authorizationToken, [
      bool isCustomHeaders = false,
    ]
  ) {
    if (isCustomHeaders) _headers.clear();
    if (requireAuth) {
      headers..addAll({'Authorization': 'Bearer ${authorizationToken ?? ''}'});
    }

    return headers;
  }
}