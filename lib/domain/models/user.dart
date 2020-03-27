import 'package:equatable/equatable.dart';
import 'package:ubermove/domain/core/token.mixin.dart';

class User extends Equatable with Tokenizable {
  /// User Id
  final String id;
  final String username;
  final String ruc;
  final String merchant;
  final String role;
  final String merchantId;
  final String localId;
  final String cashId;

  User({
    this.id,
    this.username,
    this.ruc,
    this.merchant,
    this.role,
    this.merchantId,
    this.localId,
    this.cashId,
  })  : assert(id != null),
        assert(username != null),
        assert(role != null);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['usuarioid'],
      username: json['username'],
      ruc: json['ruc'],
      merchant: json['merchant'],
      role: json['role'],
      merchantId: json['merchantId'],
      localId: json['localId'],
      cashId: json['cajaid'],
    )
      ..nbf = json['nbf']
      ..iat = json['iat']
      ..aud = json['aud']
      ..exp = json['exp']
      ..iss = json['iss'];
  }

  @override
  List<Object> get props => [id, username, ruc, role];
}
