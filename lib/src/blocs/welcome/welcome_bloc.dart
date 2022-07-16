import 'dart:async';

import 'package:flutter_fruit_hub/src/blocs/welcome/welcome_event.dart';

class WelcomeBloc {
  final _eventController = StreamController.broadcast();

  Stream getEventStream() {
    return _eventController.stream;
  }

  void addEvent(WelcomeEvent event) {
    _eventController.sink.add(event);
  }

  void dispose() {
    _eventController.close();
  }
}
