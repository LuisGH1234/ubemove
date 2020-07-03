import 'package:equatable/equatable.dart';

import 'events.dart';

class UserState extends Equatable {
  final PaymentMethodListEvent paymentMethodList;
  final JobListEvent jobListEvent;
  final CreateJobEvent createJobEvent;

  UserState({this.paymentMethodList, this.jobListEvent, this.createJobEvent});

  factory UserState.init() {
    return UserState(
        paymentMethodList: PaymentMethodListEvent(),
        jobListEvent: JobListEvent(),
        createJobEvent: CreateJobEvent());
  }

  factory UserState.from(
    UserState state, {
    PaymentMethodListEvent paymentMethodList,
    JobListEvent jobListEvent,
    CreateJobEvent createJobEvent,
  }) {
    return UserState(
        paymentMethodList: paymentMethodList ?? state.paymentMethodList,
        jobListEvent: jobListEvent ?? state.jobListEvent,
        createJobEvent: createJobEvent ?? state.createJobEvent);
  }

  @override
  List<Object> get props => [paymentMethodList, createJobEvent, jobListEvent];
}
