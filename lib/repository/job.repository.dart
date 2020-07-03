import 'package:ubermove/domain/models/job.dart';
import '../network/core/api_manager.dart';
import 'package:ubermove/network/services/job.dart' as jobServices;

class JobRepository {
  JobRepository._();

  factory JobRepository.build() {
    return JobRepository._();
  }

  Future<void> creatJobRequested(Job job) async {
    await jobServices.creatJobRequested(job);
  }
}
