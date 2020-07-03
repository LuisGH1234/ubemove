import 'package:ubermove/domain/core/base.domain.dart';
import 'package:ubermove/domain/models/company.dart';
import 'package:ubermove/domain/models/payment.dart';
import 'package:ubermove/domain/models/paymentMethodClient.dart';
import 'package:ubermove/domain/models/user.dart';

class Job extends Entity {
  final int id;
  final bool active;
  final num weight;
  final DateTime date;
  final String originAddress;
  final String destinyAddress;
  final num originLatitude;
  final num originLongitude;
  final num destinyLatitude;
  final num destinyLongitude;
  final int status;
  final Payment payment;
  final int totalPrice;
  final PaymentMethodClient paymentMethodClient;
  final Company company;
  final User user;

  Job(
      {this.id,
      this.active,
      this.weight,
      this.date,
      this.originAddress,
      this.destinyAddress,
      this.originLatitude,
      this.originLongitude,
      this.destinyLatitude,
      this.destinyLongitude,
      this.status,
      this.payment,
      this.totalPrice,
      this.paymentMethodClient,
      this.company,
      this.user});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      active: json['active'],
      weight: json['weight'],
      date: DateTime.parse(json['date']),
      originAddress: json['originAddress'],
      destinyAddress: json['destinyAddress'],
      originLatitude: json['originLatitude'],
      originLongitude: json['originLongitude'],
      totalPrice: json['totalPrice'],
      destinyLatitude: json['destinyLatitude'],
      destinyLongitude: json['destinyLongitude'],
      status: json['status'],
      payment: Payment.fromJson(json['payment']),
      company: Company.fromJson(json['company']),
    );
  }

  @override
  Map<String, dynamic> convertirJson() => {
        'weight': weight,
        'date': date.toString(),
        'originAddress': originAddress,
        'destinyAddress': destinyAddress,
        'originLatitude': originLatitude,
        'originLongitude': originLongitude,
        'destinyLatitude': destinyLatitude,
        'destinyLongitude': destinyLongitude,
        'status': status,
        'payment': payment != null ? payment.convertirJson() : null,
        'totalPrice': totalPrice,
        'paymentMethodClient': paymentMethodClient != null
            ? paymentMethodClient.convertirJson()
            : null,
        'company': company != null ? company.convertirJson() : null,
        'user': user != null ? user.convertirJson() : null,
      };

  @override
  List<Object> get props => [id, date, weight];
}
