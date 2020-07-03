import 'package:equatable/equatable.dart';

import 'events.dart';

class UserState extends Equatable {
  final PaymentMethodListEvent paymentMethodList;
  final JobListEvent jobListEvent;
  final CreateJobEvent createJobEvent;
  final CompanyListEvent companyListEvent;
  final UpdateProfileEvent updateProfileEvent;

  UserState(
      {this.paymentMethodList,
      this.jobListEvent,
      this.createJobEvent,
      this.companyListEvent,
      this.updateProfileEvent});

  factory UserState.init() {
    return UserState(
        paymentMethodList: PaymentMethodListEvent(),
        jobListEvent: JobListEvent(),
        createJobEvent: CreateJobEvent(),
        companyListEvent: CompanyListEvent(),
        updateProfileEvent: UpdateProfileEvent());
  }

  factory UserState.from(UserState state,
      {PaymentMethodListEvent paymentMethodList,
      JobListEvent jobListEvent,
      CreateJobEvent createJobEvent,
      CompanyListEvent companyListEvent,
      UpdateProfileEvent updateProfileEvent}) {
    return UserState(
        paymentMethodList: paymentMethodList ?? state.paymentMethodList,
        jobListEvent: jobListEvent ?? state.jobListEvent,
        createJobEvent: createJobEvent ?? state.createJobEvent,
        companyListEvent: companyListEvent ?? state.companyListEvent,
        updateProfileEvent: updateProfileEvent ?? state.updateProfileEvent);
  }

  @override
  List<Object> get props => [
        paymentMethodList,
        createJobEvent,
        jobListEvent,
        companyListEvent,
        updateProfileEvent
      ];
}
