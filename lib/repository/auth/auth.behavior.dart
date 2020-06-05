import 'package:ubermove/domain/models/auth.dart';
import 'package:ubermove/domain/models/user.dart';

abstract class IAuthRepository {
  Future<AuthEntity> login(String username, String password);
  Future<AuthEntity> registro(User data);
}
