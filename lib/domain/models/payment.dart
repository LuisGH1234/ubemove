import 'package:ubermove/domain/core/base.domain.dart';

class Payment extends Entity{
  final int id;
  final bool active;
  final int quantity;
  final int currency;

  Payment(
      {this.id,
        this.active,
        this.quantity,
        this.currency
        }): assert (id != null);

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
        id: json['id'],
        active: json['active'],
        quantity: json['quantity'],
        currency: json['currency']);
  }

  @override
  Map<String, dynamic> convertirJson() => {
    "id": id,
    "active": active,
    "quantity": quantity,
    "currency": currency
  };

  @override
  // TODO: implement props
  List<Object> get props => [id, active, quantity, currency];

}