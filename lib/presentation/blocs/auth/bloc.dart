import 'dart:convert';

import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/presentation/blocs/auth/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/presentation/blocs/core/base_bloc.dart';
import 'package:ubermove/repository/auth/auth.implemets.dart';
import './events.dart';
import '../core/base_events.dart' show BaseEvent;

class AuthBloc extends BaseBloc<AuthState> {
  final AuthRepository repository;

  AuthBloc._({this.repository});

  factory AuthBloc.build() {
    return AuthBloc._(repository: AuthRepository.build());
  }

  void authenticated() {
    // Usar el metodo "login" cuando el backend tenga el servicio de loggeo
    add(AuthenticateEvent()..isAuthenticated = true);
  }

  void notAuthenticated() {
    add(AuthenticateEvent()..isAuthenticated = false);
  }

  void login(String username, String password) async {
    addLoading(LoginEvent());
    try {
      print(username + password);
      final data = await repository.login(username, password);
      final prefs = await SharedPreferences.getInstance();
      print("accessToken: " + data.accessToken);
      await prefs.setString('token', data.accessToken);
      await prefs.setInt('userID', data.user.id);
      await prefs.setString('user', json.encode(data.user.convertirJson()));
      addSuccess(LoginEvent(value: data.user));
    } on Exception catch (ex) {
      addError(LoginEvent(), ex.toString());
    }
  }

  void registro(User dataUser) async {
    addLoading(RegistroEvent());
    try {
      print(dataUser.password);
      final data = await repository.registro(dataUser);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data.accessToken);
      await prefs.setInt('userID', data.user.id);
      await prefs.setString('user', json.encode(data.user.convertirJson()));
      addSuccess(RegistroEvent(value: data.user));
      print('Print Registro');
    } on Exception catch (ex) {
      addError(RegistroEvent(), ex.toString());
      print(ex.toString());
    }
  }

  @override
  AuthState get initialState => AuthState.init();

  @override
  Stream<AuthState> mapEventToState(BaseEvent event) async* {
    // https://github.com/felangel/bloc/issues/103#issuecomment-464355033
    /**
     * Always return a new (instance) of the state.
     * Blocs will ignore duplicate states, thats why 
     * a new instance is returned.
     */
    switch (event.runtimeType) {
      case AuthenticateEvent:
        yield AuthState.from(state, authEvent: event);
        break;
      case LoginEvent:
        yield AuthState.from(state,
            loginEvent: event, user: (event as LoginEvent).value)
          ..isAuthenticated = !event.error && !event.loading;
        break;
      case RegistroEvent:
        yield AuthState.from(state,
            registroEvent: event, user: (event as RegistroEvent).value)
          ..isAuthenticated = !event.error && !event.loading;
        break;
      default:
        print("AuthBloc: mapEventToState default on switch statement");
        yield AuthState.from(state);
        break;
    }
  }
}
