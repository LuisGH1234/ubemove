import 'package:ubermove/domain/models/user.dart';

import '../core/base_events.dart';

class AuthenticateEvent with BaseEvent {
  bool isAuthenticated = false;

  AuthenticateEvent();
  factory AuthenticateEvent.init() {
    return AuthenticateEvent();
  }
}

class LoginEvent = SinglePayload<User> with BaseEvent;
class RegistroEvent = SinglePayload<User> with BaseEvent;
