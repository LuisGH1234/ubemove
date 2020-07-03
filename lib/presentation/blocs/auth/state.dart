import 'package:equatable/equatable.dart';
import 'package:ubermove/domain/models/user.dart';

import 'events.dart';

class AuthState extends Equatable {
  final AuthenticateEvent authEvent;
  final LoginEvent loginEvent;
  final RegistroEvent registroEvent;
  final User user;

  AuthState({this.authEvent, this.loginEvent, this.registroEvent, this.user});

  factory AuthState.init() {
    return AuthState(
        authEvent: AuthenticateEvent(),
        loginEvent: LoginEvent(),
        registroEvent: RegistroEvent());
  }

  factory AuthState.from(AuthState state,
      {AuthenticateEvent authEvent,
      LoginEvent loginEvent,
      RegistroEvent registroEvent,
      User user}) {
    return AuthState(
      authEvent: authEvent ?? state.authEvent,
      loginEvent: loginEvent ?? state.loginEvent,
      registroEvent: registroEvent ?? state.registroEvent,
      user: user ?? state.user,
    );
  }

  bool get isAuthenticated => authEvent.isAuthenticated ?? false;
  set isAuthenticated(bool value) => authEvent.isAuthenticated = value;

  @override
  List<Object> get props => [authEvent, loginEvent, registroEvent];
}
