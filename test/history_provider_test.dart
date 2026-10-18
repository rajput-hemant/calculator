import 'package:calculator/models/history_entry.dart';
import 'package:calculator/provider/history_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('History provider', () {
    test('add appends entry and caps at 100', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      final notifier = container.read(historyProvider.notifier);

      await notifier.clearAll();
      for (int i = 0; i < 5; i++) {
        await notifier.add(HistoryEntry(
          expression: '$i+1',
          result: '${i + 1}',
          timestamp: DateTime.now(),
        ));
      }

      final entries = container.read(historyProvider);
      expect(entries.length, 5);
      expect(entries.first.expression, '4+1');
    });

    test('clear-all empties list', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      final notifier = container.read(historyProvider.notifier);

      await notifier.add(HistoryEntry(
        expression: '2+2',
        result: '4',
        timestamp: DateTime.now(),
      ));

      await notifier.clearAll();
      expect(container.read(historyProvider), isEmpty);
    });

    test('history persists and reloads across provider restarts', () async {
      SharedPreferences.setMockInitialValues({});
      final container1 = ProviderContainer();
      final notifier1 = container1.read(historyProvider.notifier);
      await notifier1.add(HistoryEntry(
        expression: '1+1',
        result: '2',
        timestamp: DateTime.now(),
      ));

      // Recreate provider container (simulating app restart)
      final container2 = ProviderContainer();
      final notifier2 = container2.read(historyProvider.notifier);
      await notifier2.load();
      final entries = container2.read(historyProvider);
      expect(entries, hasLength(1));
      expect(entries.first.expression, '1+1');
      expect(entries.first.result, '2');
    });
  });
}
