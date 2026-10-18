import 'package:calculator/models/models.dart';
import 'package:calculator/provider/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> settle() => pumpEventQueue();

  test('exposes the default preferences synchronously', () {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    final preferences = container.read(preferencesProvider);

    expect(preferences.themeMode, ThemeMode.system);
    expect(preferences.unitIndexes[Units.area], [8, 7]);
  });

  test('loads stored preferences', () async {
    SharedPreferences.setMockInitialValues({
      'themeMode': 'dark',
      Units.area.toString(): ['1', '2'],
    });
    final container = ProviderContainer.test();

    container.read(preferencesProvider);
    await settle();

    final preferences = container.read(preferencesProvider);
    expect(preferences.themeMode, ThemeMode.dark);
    expect(preferences.unitIndexes[Units.area], [1, 2]);
    // Keys without a stored value keep their defaults.
    expect(preferences.unitIndexes[Units.length], [5, 0]);
  });

  test(
    'falls back to system for missing or unknown stored themeMode',
    () async {
      SharedPreferences.setMockInitialValues({
        // The retired 'darkMode' bool must not resurrect as an override.
        'darkMode': true,
        'themeMode': 'purple',
      });
      final container = ProviderContainer.test();

      container.read(preferencesProvider);
      await settle();

      expect(container.read(preferencesProvider).themeMode, ThemeMode.system);
    },
  );

  test('loads the retired square shape as squircle', () async {
    SharedPreferences.setMockInitialValues({'buttonShape': 'square'});
    final container = ProviderContainer.test();

    container.read(preferencesProvider);
    await settle();

    expect(
      container.read(preferencesProvider).buttonShape,
      ButtonShape.squircle,
    );
  });

  test('setThemeMode updates the state and persists it', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(preferencesProvider);
    await settle();

    container.read(preferencesProvider.notifier).setThemeMode(ThemeMode.light);
    await settle();

    expect(container.read(preferencesProvider).themeMode, ThemeMode.light);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('themeMode'), 'light');
  });

  test('setUnitIndexes updates the map and persists it', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(preferencesProvider);
    await settle();

    container.read(preferencesProvider.notifier).setUnitIndexes(Units.area, [
      3,
      4,
    ]);
    await settle();

    expect(container.read(preferencesProvider).unitIndexes[Units.area], [3, 4]);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList(Units.area.toString()), ['3', '4']);
  });

  test('setUnitIndexes notifies listeners so the UI rebuilds', () async {
    // Regression: mutating the map in place left the state object identical
    // and silenced the rebuild.
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(preferencesProvider);
    await settle();

    var notifications = 0;
    container.listen(preferencesProvider, (_, _) => notifications++);

    container.read(preferencesProvider.notifier).setUnitIndexes(Units.currency, [
      2,
      5,
    ]);
    await settle();

    expect(notifications, 1);
    expect(container.read(preferencesProvider).unitIndexes[Units.currency], [
      2,
      5,
    ]);
  });

  test('notifies listeners when setThemeMode is called', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(preferencesProvider);
    await settle();

    var notifications = 0;
    container.listen(preferencesProvider, (_, _) => notifications++);

    container.read(preferencesProvider.notifier).setThemeMode(ThemeMode.dark);

    expect(notifications, 1);
  });

  testWidgets('widget wiring drives themeMode from the provider', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: _ThemeProbe()));
    await tester.pump();

    MaterialApp app() => tester.widget<MaterialApp>(find.byType(MaterialApp));

    // The default is to follow the system, never a baked-in dark or light.
    expect(app().themeMode, ThemeMode.system);

    await tester.tap(find.text('light'));
    await tester.pump();
    expect(app().themeMode, ThemeMode.light);

    await tester.tap(find.text('dark'));
    await tester.pump();
    expect(app().themeMode, ThemeMode.dark);
  });
}

// Mirrors how lib/main.dart watches the provider and how the settings screen
// reads its notifier.
class _ThemeProbe extends ConsumerWidget {
  const _ThemeProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(preferencesProvider).themeMode;

    return MaterialApp(
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () => ref
                  .read(preferencesProvider.notifier)
                  .setThemeMode(ThemeMode.light),
              child: const Text('light'),
            ),
            TextButton(
              onPressed: () => ref
                  .read(preferencesProvider.notifier)
                  .setThemeMode(ThemeMode.dark),
              child: const Text('dark'),
            ),
          ],
        ),
      ),
    );
  }
}
