import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/common/constants/api_urls.dart' show AUTHORITY_URI;

enum RequestType { GET, POST, PUT, DELETE }

Future<Map<String, String>> _getHeaders(
    RequestType type, bool tokenRequired) async {
  final Map<String, String> headers = {
    HttpHeaders.acceptHeader: 'application/json',
  };
  if (type != RequestType.GET) {
    headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }
  if (tokenRequired) {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }
  return headers;
}

class ApiManager {
  static Future<http.Response> get(String path,
      {Map<String, dynamic> params, bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.GET, tokenRequired);
    final response = await http.get(uri, headers: headers);
    return decorateResponse(response);
  }

  static Future<http.Response> post(String path,
      {Map<String, dynamic> params,
      Object body,
      bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.POST, tokenRequired);
    final response =
        await http.post(uri, headers: headers, body: json.encode(body));
    return decorateResponse(response);
  }

  static Future<http.Response> put(String path,
      {Map<String, dynamic> params,
      Object body,
      bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.PUT, tokenRequired);
    final response =
        await http.put(uri, headers: headers, body: json.encode(body));
    return decorateResponse(response);
  }

  static Future<http.Response> delete(String path,
      {Map<String, dynamic> params, bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.DELETE, tokenRequired);
    final response = await http.delete(uri, headers: headers);
    return decorateResponse(response);
  }
}

extension PayloadResponse on http.Response {
  Map<String, dynamic> get payload => json.decode(this.body);
}

http.Response decorateResponse(http.Response response) {
  final code = response.statusCode;
  //final body = json.decode(response.body);
  print(code);
  final body = response.payload;
  print(body);

  switch (code) {
    case HttpStatus.internalServerError:
      throw HttpException('Error interno del servidor');
    case HttpStatus.unauthorized:
      throw HttpException(body['message'] as String);
    case HttpStatus.badRequest:
      throw HttpException(body['message'] as String);
    case HttpStatus.notFound:
      throw HttpException(body['message'] as String);
    case HttpStatus.forbidden:
      throw HttpException(body['message'] as String);
    default:
      return response;
  }
}
