import 'package:http/http.dart' as http;
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/common/constants/api_urls.dart'
    show AUTH_PATH, USER_PATH;

Future<http.Response> login(String username, String password) {
  final path = "$AUTH_PATH/login";
  final data = {'email': username, 'password': password};
  return ApiManager.post(path, body: data, tokenRequired: false);
}

Future<http.Response> registro(User data) {
  final path = "$AUTH_PATH/signup";
  return ApiManager.post(path,
      body: data.convertirJson(), tokenRequired: false);
}

Future<http.Response> myPaymentMethods(int userID) {
  final path = "$USER_PATH/$userID/paymentmethods";
  return ApiManager.get(path);
}

Future<http.Response> myRequestedJobs(int userID) {
  final path = "$USER_PATH/$userID/jobs";
  return ApiManager.get(path);
}

Future<http.Response> updateProfile(dynamic data) {
  final path = "$USER_PATH/updateprofile";
  return ApiManager.post(path, body: data.convertirJson());
}
