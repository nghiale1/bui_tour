import 'dart:async';

import 'state.dart';

class BuiTourStateManager {
  final Map<String, State> _states = {};

  void registerState<T>(String key, T initialState) {
    if (!_states.containsKey(key)) {
      _states[key] = State<T>(initialState);
    }
  }

  T getState<T>(String key) {
    final state = _states[key];
    if (state is State<T>) {
      return state.stateValue;
    } else {
      throw Exception('State $key not registered or type mismatch');
    }
  }

  Future<void> setState<T>(String key, T newValue,
      {bool isAsync = false}) async {
    final state = _states[key];
    if (state is State<T>) {
      if (isAsync) {
        await _updateStateAsync(state, newValue);
      } else {
        _updateStateSync(state, newValue);
      }
    } else {
      throw Exception('State $key not registered or type mismatch');
    }
  }

  void resetState(String key) {
    if (_states.containsKey(key)) {
      _states.remove(key);
    }
  }

  void _updateStateSync<T>(State<T> state, T newValue) {
    state.stateValue = newValue;
  }

  Future<void> _updateStateAsync<T>(State<T> state, T newValue) async {
    await Future.delayed(Duration(seconds: 1));
    state.stateValue = newValue;
  }

  Stream<T> listen<T>(String key) {
    final state = _states[key];
    if (state is State<T>) {
      return state.stream;
    } else {
      throw Exception('State $key not registered or type mismatch');
    }
  }
}
