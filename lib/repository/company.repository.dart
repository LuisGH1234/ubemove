import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/domain/models/paymentMethod.dart';
import '../network/core/api_manager.dart';
import 'package:ubermove/network/services/user.dart' as userServices;

class CompanyRepository {
  CompanyRepository._();

  factory CompanyRepository.build() {
    // Inject Dependencies
    return CompanyRepository._(/* dependencies to be injected */);
  }

  Future<List<PaymentMethod>> getCompanies() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getInt('userID');
    final response = await userServices.myPaymentMethods(userID);
    return List.from(response.payload['data'])
        .map((e) => PaymentMethod.fromJson(e))
        .toList();
  }
}
