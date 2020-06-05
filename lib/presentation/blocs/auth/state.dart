import 'package:equatable/equatable.dart';

import 'events.dart';

class AuthState extends Equatable {
  final AuthenticateEvent authEvent;
  final LoginEvent loginEvent;
  final RegistroEvent registroEvent;

  AuthState({this.authEvent, this.loginEvent, this.registroEvent});

  factory AuthState.init() {
    return AuthState(authEvent: AuthenticateEvent(), loginEvent: LoginEvent(), registroEvent: RegistroEvent());
  }

  factory AuthState.from([AuthState state]) {
    if (state != null) {
      return AuthState(
          authEvent: state.authEvent, loginEvent: state.loginEvent,registroEvent: state.registroEvent );
    } else
      return AuthState();
  }

  bool get isAuthenticated => authEvent.isAuthenticated ?? false;
  set isAuthenticated(bool value) => authEvent.isAuthenticated = value;

  @override
  List<Object> get props => [authEvent, loginEvent, registroEvent];
}
