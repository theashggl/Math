import 'dart:async';
import 'package:flutter_apps/Data/counter_event.dart';

class CounterBloc {
  int _counter = 1;

  final _counterStateController = StreamController<int>.broadcast();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  // For events, exposing only a sink which is an input
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is RandomEvent) {
      if (event.value > 0 && event.value <= 10) {
        _counter = event.value;
      }
    } else if (event is IncrementEvent && _counter < 10) {
      _counter++;
    } else {
      if (event is DecrementEvent && _counter >= 2 && _counter <= 10) {
        _counter--;
      }
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
