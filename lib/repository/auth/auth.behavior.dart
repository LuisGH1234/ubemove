import 'package:ubermove/domain/core/base.domain.dart';

abstract class IAuthRepository {
  Future<SuccessLogin> login(String username, String password);
}
