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
    return http.get(uri, headers: headers);
  }

  static Future<http.Response> post(String path,
      {Map<String, dynamic> params,
      Object body,
      bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.POST, tokenRequired);
    return http.post(uri, headers: headers, body: json.encode(body));
  }

  static Future<http.Response> put(String path,
      {Map<String, dynamic> params,
      Object body,
      bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.PUT, tokenRequired);
    return http.put(uri, headers: headers, body: json.encode(body));
  }

  static Future<http.Response> delete(String path,
      {Map<String, dynamic> params, bool tokenRequired = true}) async {
    final uri = Uri.http(AUTHORITY_URI, path, params);
    final headers = await _getHeaders(RequestType.DELETE, tokenRequired);
    return http.delete(uri, headers: headers);
  }
}
