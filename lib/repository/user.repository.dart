import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/domain/models/company.dart';
import 'package:ubermove/domain/models/job.dart';
import 'package:ubermove/domain/models/paymentMethod.dart';
import 'package:ubermove/domain/models/user.dart';
import '../network/core/api_manager.dart';
import 'package:ubermove/network/services/user.dart' as userServices;
import 'package:ubermove/network/services/company.dart' as companyServices;

class UserRepository {
  UserRepository._();

  factory UserRepository.build() {
    // Inject Dependencies
    return UserRepository._(/* dependencies to be injected */);
  }

  Future<List<PaymentMethod>> getMyPaymentMethods() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID');
    final response = await userServices.myPaymentMethods(userID);
    return List.from(response.payload['data'])
        .map((e) => PaymentMethod.fromJson(e))
        .toList();
  }

  Future<List<Company>> getMyCompanies() async {
    final response = await companyServices.companies();
    return List.from(response.payload['data'])
        .map((e) => Company.fromJson(e))
        .toList();
  }

  Future<List<dynamic>> geMyRequestedJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID');
    final response = await userServices.myRequestedJobs(userID);
    return List.from(response.payload['data'])
        .map((e) => Job.fromJson(e))
        .toList();
  }

  Future<void> updateMyProfile(User data) async {
    return userServices.updateProfile(data);
  }
}
