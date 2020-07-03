import 'package:ubermove/domain/core/base.domain.dart';

class PaymentMethod extends Entity {
  final String description;
  final int id;
  final bool active;

  PaymentMethod({this.description, this.id, this.active});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'],
      description: json['description'],
      active: json['active'],
    );
  }

  @override
  Map<String, dynamic> convertirJson() => {
        'description': description,
      };

  @override
  List<Object> get props => [id, active];
}
