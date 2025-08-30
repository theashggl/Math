abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class RandomEvent extends CounterEvent {
  int value;
  RandomEvent(this.value);
}
