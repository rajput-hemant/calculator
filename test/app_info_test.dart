import 'package:calculator/provider/app_info_provider.dart';
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
    // Stands in for what the platform reports from pubspec's `version:`.
    PackageInfo.setMockInitialValues(
      appName: 'Calculator',
      packageName: 'com.capybara.calculator',
      version: '9.9.9',
      buildNumber: '42',
      buildSignature: '',
    );
  });

  test('the app version is read from the bundle, never hardcoded', () async {
    final container = ProviderContainer.test();

    expect(await container.read(appVersionProvider.future), '9.9.9');
  });

  testWidgets('the settings screen shows the bundle version', (tester) async {
    SharedPreferences.setMockInitialValues({});
    // The settings list is lazy; the version row sits below the default 800x600.
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

    expect(find.text('9.9.9'), findsOneWidget);
  });
}
