import 'package:bloc/bloc.dart';
import 'package:ubermove/presentation/blocs/auth/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ubermove/repository/auth/auth.implemets.dart';
import './events.dart';
import '../core/base_events.dart' show BaseEvent;
import '../../../common/exceptions/excpetions.dart';

class AuthBloc extends Bloc<BaseEvent, AuthState> {
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
    add(LoginEvent()
      ..loading = true
      ..error = false);
    try {
      final data = await repository.login(username, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data.token);
      add(LoginEvent()
        ..value = data.message
        ..loading = false
        ..error = false);
    } on LoginException catch (ex) {
      add(LoginEvent()
        ..message = ex.message
        ..error = true
        ..loading = false);
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
      default:
        print("AuthBloc: mapEventToState default on switch statement");
        yield AuthState.from(state);
        break;
    }
  }
}
