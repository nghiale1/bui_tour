import 'dart:async';

class State<T> {
  T _stateValue;
  final _controller = StreamController<T>.broadcast();

  State(this._stateValue);

  Stream<T> get stream => _controller.stream;

  set stateValue(T value) {
    _controller.add(value);
    _stateValue = value;
  }

  T get stateValue => _stateValue;
}
