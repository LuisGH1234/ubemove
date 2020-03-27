import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiUtil {
  static void manage(
      {Future<http.Response> Function() callApi,
      void Function() onInit,
      void Function(dynamic body) onSuccess,
      void Function(String) onError}) async {
    assert(callApi != null, "ApiUtil manage callApi parameter is null");
    assert(onSuccess != null, "ApiUtil manage onSuccess parameter is null");
    assert(onError != null, "ApiUtil manage onError parameter is null");
    if (onInit != null) onInit();
    try {
      final res = await callApi();
      final body = json.decode(res.body);
      if (body['error'] as bool == false && res.statusCode == HttpStatus.ok) {
        onSuccess(body);
      } else {
        final String message = body['message'] ?? body['Message'];
        onError(message);
      }
    } on SocketException catch (_) {
      final errorMessage =
          "Revise su conexión a internet, vuelva a intentarlo.";
      if (onError != null) onError(errorMessage);
    }
  }

  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = ApiUtil._decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
