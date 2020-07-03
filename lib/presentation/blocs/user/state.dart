import 'package:equatable/equatable.dart';

import 'events.dart';

class UserState extends Equatable {
  final PaymentMethodListEvent paymentMethodList;
  final JobListEvent jobListEvent;
  final CreateJobEvent createJobEvent;
  final CompanyListEvent companyListEvent;

  UserState(
      {this.paymentMethodList,
      this.jobListEvent,
      this.createJobEvent,
      this.companyListEvent});

  factory UserState.init() {
    return UserState(
        paymentMethodList: PaymentMethodListEvent(),
        jobListEvent: JobListEvent(),
        createJobEvent: CreateJobEvent(),
        companyListEvent: CompanyListEvent());
  }

  factory UserState.from(
    UserState state, {
    PaymentMethodListEvent paymentMethodList,
    JobListEvent jobListEvent,
    CreateJobEvent createJobEvent,
    CompanyListEvent companyListEvent,
  }) {
    return UserState(
        paymentMethodList: paymentMethodList ?? state.paymentMethodList,
        jobListEvent: jobListEvent ?? state.jobListEvent,
        createJobEvent: createJobEvent ?? state.createJobEvent,
        companyListEvent: companyListEvent ?? state.companyListEvent);
  }

  @override
  List<Object> get props =>
      [paymentMethodList, createJobEvent, jobListEvent, companyListEvent];
}
