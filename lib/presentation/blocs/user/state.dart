import 'package:equatable/equatable.dart';

import 'events.dart';

class UserState extends Equatable {
  final PaymentMethodListEvent paymentMethodList;
  final CompanyListEvent companyListEvent;

  UserState({this.paymentMethodList, this.companyListEvent});

  factory UserState.init() {
    return UserState(paymentMethodList: PaymentMethodListEvent(), companyListEvent: CompanyListEvent());
  }

  factory UserState.from([UserState state]) {
    if (state != null) {
      return UserState(paymentMethodList: state.paymentMethodList, companyListEvent: state.companyListEvent);
    } else
      return UserState();
  }

  @override
  List<Object> get props => [paymentMethodList, companyListEvent];
}
