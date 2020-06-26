import 'dart:convert';

import 'package:ubermove/domain/models/user.dart';
import 'package:ubermove/network/services/user.dart';
import 'package:ubermove/presentation/blocs/auth/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/presentation/blocs/core/base_bloc.dart';
import 'package:ubermove/repository/auth/auth.implemets.dart';
import './events.dart';
import '../core/base_events.dart' show BaseEvent;
import '../../../common/exceptions/excpetions.dart';

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
    // add(LoginEvent()
    //   ..loading = true
    //   ..error = false);
    // try {
    //   final data = await repository.login(username, password);
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('token', data.accessToken);
    //   add(LoginEvent()
    //     ..value = data.user
    //     ..loading = false
    //     ..error = false);
    // } on LoginException catch (ex) {
    //   add(LoginEvent()
    //     ..message = ex.message
    //     ..error = true
    //     ..loading = false);
    // }
    addLoading(LoginEvent());
    try {
      print(username + password);
      final data = await repository.login(username, password);
      final prefs = await SharedPreferences.getInstance();
      print("accessToken: " + data.accessToken);
      await prefs.setString('token', data.accessToken);
      await prefs.setString('user',json.encode(data.user.convertirJson()) );
      addSuccess(LoginEvent(value: data.user));
    } on Exception catch (ex) {
      addError(LoginEvent(), ex.toString());
    }
  }

  void registro(User dataUser) async{
    addLoading(RegistroEvent());
    try {
      print(dataUser.password);
      final data = await repository.registro(dataUser);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data.accessToken);
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
        yield AuthState(authEvent: event, loginEvent: state.loginEvent);
        break;
      case LoginEvent:
        yield AuthState(authEvent: state.authEvent, loginEvent: event)
          ..isAuthenticated = !event.error && !event.loading;
        break;
      case RegistroEvent:
        yield AuthState(authEvent: state.authEvent, registroEvent: event, loginEvent: state.loginEvent)
          ..isAuthenticated = !event.error && !event.loading;
        break;
      default:
        print("AuthBloc: mapEventToState default on switch statement");
        yield AuthState.from(state);
        break;
    }
  }
}
