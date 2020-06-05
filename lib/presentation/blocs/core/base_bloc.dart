import 'package:bloc/bloc.dart';
import 'package:ubermove/presentation/blocs/core/base_events.dart';

abstract class BaseBloc<State> extends Bloc<BaseEvent, State> {
  void addLoading(BaseEvent event) {
    add(event..loading = true);
  }

  void addSuccess(BaseEvent event) {
    add(event);
  }

  void addError(BaseEvent event, String message) {
    add(event
      ..error = true
      ..message = message);
  }
}
