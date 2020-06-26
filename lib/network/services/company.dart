import 'package:http/http.dart' as http;
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/common/constants/api_urls.dart';

Future<http.Response> companies() {
  final path = "/api/v1/companies";
  return ApiManager.get(path);
}
