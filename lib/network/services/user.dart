import 'package:http/http.dart' as http;
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/common/constants/api_urls.dart' show USER_PATH;

Future<http.Response> login(String username, String password) {
  final path = "$USER_PATH/login";
  final data = {'username': username, 'password': password};
  return ApiManager.post(path, body: data, tokenRequired: false);
}

Future<http.Response> registro(User data) {
  final path = "$USER_PATH/signup";
  return ApiManager.post(path, body: data.convertirJson(), tokenRequired: false);
}
