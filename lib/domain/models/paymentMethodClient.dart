import 'package:ubermove/domain/core/base.domain.dart';

class PaymentMethodClient extends Entity {
  final int id;
  final bool active;
  final dynamic payments;

  PaymentMethodClient({this.id, this.active = true, this.payments});

  factory PaymentMethodClient.fromJson(Map<String, dynamic> json) {
    return PaymentMethodClient(
      id: json['id'],
      active: json['active'],
    );
  }

  @override
  Map<String, dynamic> convertirJson() => {
        'id': id,
      };

  @override
  List<Object> get props => [id, active];
}
