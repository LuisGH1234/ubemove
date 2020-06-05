import 'package:equatable/equatable.dart';
import 'package:ubermove/domain/models/user.dart';

class AuthEntity extends Equatable {
  final String expiresIn;
  final String accessToken;
  final User user;

  AuthEntity({this.expiresIn, this.accessToken, this.user})
      : assert(user != null),
        assert(expiresIn != null),
        assert(accessToken != null);

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
        expiresIn: json['expiresIn'],
        accessToken: json['accessToken'],
        user: User.fromJson(json['user']));
  }

  @override
  List<Object> get props => [expiresIn, accessToken, user];
}
