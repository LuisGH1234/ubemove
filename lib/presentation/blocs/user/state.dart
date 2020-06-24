import 'package:equatable/equatable.dart';

import 'events.dart';

class UserState extends Equatable {
  final PaymentMethodListEvent paymentMethodList;

  UserState({this.paymentMethodList});

  factory UserState.init() {
    return UserState(paymentMethodList: PaymentMethodListEvent());
  }

  factory UserState.from([UserState state]) {
    if (state != null) {
      return UserState(paymentMethodList: state.paymentMethodList);
    } else
      return UserState();
  }

  @override
  List<Object> get props => [paymentMethodList];
}
