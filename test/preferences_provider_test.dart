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

    final preferences = container.read(prefrencesProvider);

    expect(preferences.darkMode, isTrue);
    expect(preferences.tabView, isTrue);
    expect(preferences.unitIndexes[Units.area], [8, 7]);
  });

  test('loads stored preferences', () async {
    SharedPreferences.setMockInitialValues({
      'darkMode': false,
      'tabView': false,
      Units.area.toString(): ['1', '2'],
    });
    final container = ProviderContainer.test();

    container.read(prefrencesProvider);
    await settle();

    final preferences = container.read(prefrencesProvider);
    expect(preferences.darkMode, isFalse);
    expect(preferences.tabView, isFalse);
    expect(preferences.unitIndexes[Units.area], [1, 2]);
    // Keys without a stored value keep their defaults.
    expect(preferences.unitIndexes[Units.length], [5, 0]);
  });

  test('toggleDarkMode flips the state and persists it', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(prefrencesProvider);
    await settle();

    container.read(prefrencesProvider.notifier).toggleDarkMode();
    await settle();

    expect(container.read(prefrencesProvider).darkMode, isFalse);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('darkMode'), isFalse);
  });

  test('toggleTabView flips the state and persists it', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(prefrencesProvider);
    await settle();

    container.read(prefrencesProvider.notifier).toggleTabView();
    await settle();

    expect(container.read(prefrencesProvider).tabView, isFalse);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('tabView'), isFalse);
  });

  test('setUnitIndexes updates the map and persists it', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(prefrencesProvider);
    await settle();

    container.read(prefrencesProvider.notifier).setUnitIndexes(Units.area, [3, 4]);
    await settle();

    expect(container.read(prefrencesProvider).unitIndexes[Units.area], [3, 4]);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getStringList(Units.area.toString()), ['3', '4']);
  });

  test('notifies listeners when toggleDarkMode is called', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer.test();

    container.read(prefrencesProvider);
    await settle();

    var notifications = 0;
    container.listen(prefrencesProvider, (_, _) => notifications++);

    container.read(prefrencesProvider.notifier).toggleDarkMode();

    expect(notifications, 1);
  });

  testWidgets('widget wiring drives themeMode from the provider',
      (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const ProviderScope(child: _ThemeProbe()),
    );
    await tester.pump();

    MaterialApp app() => tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app().themeMode, ThemeMode.dark);

    await tester.tap(find.text('toggle'));
    await tester.pump();

    expect(app().themeMode, ThemeMode.light);
  });
}

// Mirrors how lib/main.dart watches the provider and how the settings screen
// reads its notifier.
class _ThemeProbe extends ConsumerWidget {
  const _ThemeProbe();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(prefrencesProvider).darkMode;

    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: ElevatedButton(
          onPressed: () =>
              ref.read(prefrencesProvider.notifier).toggleDarkMode(),
          child: const Text('toggle'),
        ),
      ),
    );
  }
}
