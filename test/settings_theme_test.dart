import 'package:calculator/provider/preferences_provider.dart';
import 'package:calculator/screens/settings_screen.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Calculator',
      packageName: 'com.capybara.calculator',
      version: '9.9.9',
      buildNumber: '42',
      buildSignature: '',
    );
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('theme control defaults to System and can override', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: const SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SettingsScreen)),
    );

    expect(container.read(prefrencesProvider).themeMode, ThemeMode.system);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(container.read(prefrencesProvider).themeMode, ThemeMode.light);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(container.read(prefrencesProvider).themeMode, ThemeMode.dark);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('themeMode'), 'dark');

    await tester.tap(find.text('System'));
    await tester.pumpAndSettle();
    expect(container.read(prefrencesProvider).themeMode, ThemeMode.system);
  });

  testWidgets('a removed accent preset is not selected and does not crash', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'accentColor': 0xFFFFEB3B});
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: const SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Only the Theme (System) and Shape (Round) segments are selected.
    final selected = find.byWidgetPredicate(
      (w) =>
          w is Semantics &&
          w.properties.button == true &&
          w.properties.selected == true,
    );
    expect(selected, findsNWidgets(2));
  });
}
