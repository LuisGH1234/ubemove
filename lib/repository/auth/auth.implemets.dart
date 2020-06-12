import 'package:ubermove/domain/models/auth.dart';

import '../../network/core/api_manager.dart';
import 'package:ubermove/domain/core/base.domain.dart';
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/services/user.dart' as userServices;
import 'package:ubermove/repository/auth/auth.behavior.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository._();

  factory AuthRepository.build() {
    // Inject Dependencies
    return AuthRepository._(/* dependencies to be injected */);
  }

  Future<AuthEntity> login(String username, String password) async {
    //  final response = await userServices.login(username, password);
    //    return AuthEntity.fromJson(response.payload);
    return AuthEntity(
        accessToken: 'aso', expiresIn: '7d', user: User(email: 'aaa'));
  }

  Future<AuthEntity> registro(User data) async {
    final response = await userServices.registro(data);
    return AuthEntity.fromJson(response.payload);
  }
}
