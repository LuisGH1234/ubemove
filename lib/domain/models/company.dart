import 'package:ubermove/domain/core/base.domain.dart';

class Company extends Entity {
  /// User Id
  final int id;
  final String businessName;
  final String ruc;
  final String email;
  final bool active;
  final int fare;
  final int rate;

  Company(
      {this.id,
      this.businessName,
      this.ruc,
      this.email,
      this.active,
      this.fare,
      this.rate})
      : assert(id != null);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
        id: json['id'],
        businessName: json['businessName'],
        ruc: json['ruc'],
        email: json['email'],
        active: json['active'],
        fare: json['fare'],
        rate: json['rate']);
  }

  @override
  Map<String, dynamic> convertirJson() => {
        "id": id,
        "businessName": businessName,
        "ruc": ruc,
        "lastName": email,
        "active": active,
        "fare": fare,
        "rate": rate
      };

  @override
  List<Object> get props => [id, businessName, ruc, email, active, fare, rate];
}
