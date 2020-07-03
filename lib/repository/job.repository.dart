import 'package:ubermove/domain/models/job.dart';
import '../network/core/api_manager.dart';
import 'package:ubermove/network/services/job.dart' as jobServices;

class JobRepository {
  JobRepository._();

  factory JobRepository.build() {
    return JobRepository._();
  }

  Future<List<dynamic>> geMyRequestedJobs(Job job) async {
    final response = await jobServices.creatJobRequested(job);
    return List.from(response.payload['data'])
        .map((e) => Job.fromJson(e))
        .toList();
  }
}
