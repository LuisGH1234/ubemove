import '../core/base_events.dart';

class AuthenticateEvent with BaseEvent {
  bool isAuthenticated = false;

  AuthenticateEvent();
  factory AuthenticateEvent.init() {
    return AuthenticateEvent();
  }
}

class LoginEvent = SinglePayload<String> with BaseEvent;
class RegistroEvent = SinglePayload<String> with BaseEvent;