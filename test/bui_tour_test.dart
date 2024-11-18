import 'package:bui_tour/src/state_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StateManager Test', () {
    test('Test state registration and update', () async {
      final stateManager = BuiTourStateManager();
      stateManager.registerState<int>('counter', 0);

      expect(stateManager.getState<int>('counter'), 0);

      await stateManager.setState('counter', 10);

      expect(stateManager.getState<int>('counter'), 10);
    });

    test('Test async state update', () async {
      final stateManager = BuiTourStateManager();
      stateManager.registerState<String>('name', 'John');

      await stateManager.setState('name', 'Alice', isAsync: true);

      expect(stateManager.getState<String>('name'), 'Alice');
    });
  });
}
