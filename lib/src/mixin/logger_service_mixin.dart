import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/services/logger_service.dart';

mixin LoggerBlocMixin<Event, State> on Bloc<Event, State> {
  Queue<State> states = Queue<State>();
  Queue<Event> events = Queue<Event>();

  @override
  void onEvent(Event event) async {
    events.add(event);
    LoggerService().log(
      LogLevel.INFO,
      'Executing event ${event.toString()}',
    );
    super.onEvent(event);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    LoggerService.instance.logError(error, stackTrace);
    super.onError(error, stackTrace);
  }

  @override
  void onTransition(Transition<Event, State> transition) {
    states.add(state);
    LoggerService().log(
        LogLevel.INFO,
        'Done executing event ${transition.event.toString()}');

    LoggerService().log(
        LogLevel.INFO,
        'Transitioning from ${transition.currentState.toString()} to ${transition.nextState.toString()}');
    super.onTransition(transition);
  }
}
