import 'package:calculator/models/models.dart';
import 'package:calculator/provider/preferences_provider.dart';
import 'package:calculator/screens/conversion_screen.dart';
import 'package:calculator/screens/unit_converter_screen.dart';
import 'package:calculator/widgets/keypad.dart';
import 'package:calculator/widgets/select_unit_sheet.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget app(Widget home) => ProviderScope(
    child: MaterialApp(
      theme: buildAppTheme(Tokens.seed, Brightness.light),
      home: home,
    ),
  );

  // Populate SharedPreferences with default unit indexes so the async
  // load in PreferencesNotifier finds valid data.
  final Map<String, Object> mockPrefs = {};
  final defaultPrefs = const Preferences();
  for (final entry in defaultPrefs.unitIndexes.entries) {
    mockPrefs[entry.key.toString()] = entry.value
        .map((e) => e.toString())
        .toList();
  }

  setUp(() {
    SharedPreferences.setMockInitialValues(mockPrefs);
  });

  testWidgets('ConversionScreen builds length category', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: Scaffold(body: ConversionScreen(category: Units.length)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byType(ConversionScreen),
      findsOneWidget,
      reason: 'length should build',
    );
    expect(find.byType(Keypad), findsOneWidget);
  });

  testWidgets('length screen shows the conversion and swap works', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: Scaffold(body: ConversionScreen(category: Units.length)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('From'), findsOneWidget);
    expect(find.text('To'), findsOneWidget);
    expect(find.text('1 m = 100 cm'), findsOneWidget);

    await tester.tap(find.byTooltip('Swap units'));
    await tester.pumpAndSettle();

    expect(find.text('1 cm = 0.01 m'), findsOneWidget);
  });

  testWidgets('unit pill opens a modal sheet that returns the original index', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: Scaffold(body: ConversionScreen(category: Units.length)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Metre'));
    await tester.pumpAndSettle();

    expect(find.byType(SelectUnitSheet), findsOneWidget);
    expect(find.byTooltip('Close'), findsOneWidget);

    await tester.tap(find.text('Kilometre'));
    await tester.pumpAndSettle();

    expect(find.byType(SelectUnitSheet), findsNothing);
    expect(find.text('1 km = 100000 cm'), findsOneWidget);
  });

  testWidgets('hub builds, lists currency first and filters on search', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: Scaffold(body: UnitConverterScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Currency'), findsOneWidget);
    expect(find.text('Length'), findsOneWidget);
    expect(find.text('11'), findsWidgets);

    await tester.enterText(find.byType(TextField), 'temp');
    await tester.pumpAndSettle();

    expect(find.text('Temperature'), findsOneWidget);
    expect(find.text('Currency'), findsNothing);
    expect(find.text('Length'), findsNothing);
  });

  testWidgets(
    'converter has padding around inputs and gap before unit selector',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        app(const ConversionScreen(category: Units.length)),
      );
      await tester.pump();

      expect(
        find.byWidgetPredicate((w) => w is SizedBox && w.width == Gaps.md),
        findsWidgets,
      );
    },
  );

  testWidgets(
    'typed text overflowing field scrolls so last digit entered stays visible',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(
        app(const ConversionScreen(category: Units.length)),
      );
      await tester.pump();

      for (int i = 0; i < 80; i++) {
        await tester.tap(find.text('9'));
        await tester.pumpAndSettle();
      }

      final scrollable = tester.state<ScrollableState>(
        find.descendant(
          of: find.byType(TextField).first,
          matching: find.byType(Scrollable),
        ),
      );
      expect(scrollable.position.pixels, greaterThan(0));
      expect(
        scrollable.position.pixels,
        equals(scrollable.position.maxScrollExtent),
      );
    },
  );
}
