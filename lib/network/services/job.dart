import 'package:http/http.dart' as http;
import 'package:ubermove/domain/models/job.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/common/constants/api_urls.dart' show JOB_PATH;

Future<http.Response> creatJobRequested(Job data) async {
  return ApiManager.post(JOB_PATH, body: data.convertirJson());
}
