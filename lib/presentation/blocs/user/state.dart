import 'package:equatable/equatable.dart';

import 'events.dart';

class UserState extends Equatable {
  final PaymentMethodListEvent paymentMethodList;
  final JobListEvent jobListEvent;

  UserState({this.paymentMethodList, this.jobListEvent});

  factory UserState.init() {
    return UserState(paymentMethodList: PaymentMethodListEvent());
  }

  factory UserState.from(
    UserState state, {
    PaymentMethodListEvent paymentMethodList,
    JobListEvent jobListEvent,
  }) {
    return UserState(
        paymentMethodList: paymentMethodList ?? state.paymentMethodList,
        jobListEvent: jobListEvent ?? state.jobListEvent);
  }

  @override
  List<Object> get props => [paymentMethodList];
}
