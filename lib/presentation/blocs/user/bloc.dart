import 'dart:convert';

import 'package:ubermove/domain/models/job.dart';
import 'package:ubermove/domain/models/paymentMethod.dart';
import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/presentation/blocs/core/base_bloc.dart';
import 'package:ubermove/presentation/blocs/user/state.dart';
import 'package:ubermove/repository/job.repository.dart';
import 'package:ubermove/repository/user.repository.dart';
import './events.dart';
import '../core/base_events.dart' show BaseEvent;

class UserBloc extends BaseBloc<UserState> {
  final UserRepository userRepository;
  final JobRepository jobRepository;

  UserBloc._({this.userRepository, this.jobRepository});

  factory UserBloc.build() {
    return UserBloc._(
        userRepository: UserRepository.build(),
        jobRepository: JobRepository.build());
  }

  void getMyPaymentMethods() async {
    addLoading(PaymentMethodListEvent());
    try {
      final data = await userRepository.getMyPaymentMethods();
      addSuccess(PaymentMethodListEvent(data: data ?? []));
    } on Exception catch (ex) {
      addError(PaymentMethodListEvent(), ex.toString());
    }
  }

  void getMyCompanies() async {
    addLoading(CompanyListEvent());
    try {
      final data = await userRepository.getMyCompanies();
      addSuccess(CompanyListEvent(data: data ?? []));
    } on Exception catch (ex) {
      addError(CompanyListEvent(), ex.toString());
    }
  }

  void createJob(Job job) async {
    addLoading(CreateJobEvent());
    try {
      await jobRepository.creatJobRequested(job);
      addSuccess(CreateJobEvent(success: true));
    } on Exception catch (ex) {
      addError(CreateJobEvent(), ex.toString());
    }
  }

  void udpdateProfile(User user) async {
    addLoading(UpdateProfileEvent());
    try {
      await userRepository.updateMyProfile(user);
      addSuccess(UpdateProfileEvent(success: true));
    } on Exception catch (ex) {
      addError(UpdateProfileEvent(), ex.toString());
    }
  }

  @override
  UserState get initialState => UserState.init();

  @override
  Stream<UserState> mapEventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case PaymentMethodListEvent:
        yield UserState.from(state, paymentMethodList: event);
        break;
      case CompanyListEvent:
        yield UserState.from(state, companyListEvent: event);
        break;
      case JobListEvent:
        yield UserState.from(state, jobListEvent: event);
        break;
      case CreateJobEvent:
        yield UserState.from(state, createJobEvent: event);
        break;
      case UpdateProfileEvent:
        yield UserState.from(state, updateProfileEvent: event);
        break;
      default:
        print("UserBloc: mapEventToState default on switch statement");
        yield UserState.from(state);
        break;
    }
  }
}
