import 'dart:convert';

import 'package:ubermove/domain/models/paymentMethod.dart';
import 'package:ubermove/presentation/blocs/core/base_bloc.dart';
import 'package:ubermove/presentation/blocs/user/state.dart';
import 'package:ubermove/repository/user.repository.dart';
import './events.dart';
import '../core/base_events.dart' show BaseEvent;

class UserBloc extends BaseBloc<UserState> {
  final UserRepository repository;

  UserBloc._({this.repository});

  factory UserBloc.build() {
    return UserBloc._(repository: UserRepository.build());
  }

  void getMyPaymentMethods() async {
    addLoading(PaymentMethodListEvent());
    try {
      final data = await repository.getMyPaymentMethods();
      addSuccess(PaymentMethodListEvent(data: data));
    } on Exception catch (ex) {
      addError(PaymentMethodListEvent(), ex.toString());
    }
  }

  @override
  UserState get initialState => UserState.init();

  @override
  Stream<UserState> mapEventToState(BaseEvent event) async* {
    switch (event.runtimeType) {
      case PaymentMethodListEvent:
        yield UserState(paymentMethodList: event);
        break;
      default:
        print("UserBloc: mapEventToState default on switch statement");
        yield UserState.from(state);
        break;
    }
  }
}
