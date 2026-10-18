import 'dart:ui' show Tristate;

import 'package:calculator/provider/history_provider.dart';
import 'package:calculator/screens/calculator_screen.dart';
import 'package:calculator/theme/app_icons.dart';
import 'package:calculator/theme/app_theme.dart';
import 'package:calculator/theme/tokens.dart';
import 'package:calculator/widgets/keypad.dart';
import 'package:calculator/widgets/calc_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpScreen(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp(
        theme: buildAppTheme(Tokens.seed, Brightness.light),
        home: const CalculatorScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder displayResult(String text) {
  return find.descendant(
    of: find.byType(CalcDisplay),
    matching: find.text(text),
  );
}

void main() {
  testWidgets('the header icon toggles basic and scientific in place', (
    tester,
  ) async {
    await pumpScreen(tester);
    expect(find.text('sin'), findsNothing);

    await tester.tap(find.byIcon(AppIcons.scientific));
    await tester.pumpAndSettle();
    expect(find.text('sin'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(Keypad), matching: find.byType(ListView)),
      findsNothing,
    );

    await tester.tap(find.byIcon(AppIcons.scientific));
    await tester.pumpAndSettle();
    expect(find.text('sin'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pressing = moves the equation to the tape and AC clears it', (
    tester,
  ) async {
    await pumpScreen(tester);

    for (final key in ['2', 'Plus', '2', 'Equals']) {
      await tester.tap(find.bySemanticsLabel(key));
      await tester.pumpAndSettle();
    }
    expect(displayResult('2+2'), findsOneWidget);
    expect(displayResult('4'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Clear'));
    await tester.pumpAndSettle();
    expect(displayResult('2+2'), findsNothing);
  });

  // Device automation (uiautomator) only sees widgets that carry a name, so
  // the icon-only mode key has to expose one, along with its own state.
  testWidgets(
    'the functions key is a named, stateful button in the a11y tree',
    (tester) async {
      final semantics = tester.ensureSemantics();

      await pumpScreen(tester);

      final before = tester.getSemantics(find.byIcon(AppIcons.scientific));
      expect(before.getSemanticsData().label, 'Scientific functions');
      expect(before.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
      expect(
        before.getSemanticsData().flagsCollection.isToggled,
        Tristate.isFalse,
      );

      await tester.tap(find.byIcon(AppIcons.scientific));
      await tester.pumpAndSettle();

      final after = tester.getSemantics(find.byIcon(AppIcons.scientific));
      expect(after.getSemanticsData().label, 'Scientific functions');
      expect(
        after.getSemanticsData().flagsCollection.isToggled,
        Tristate.isTrue,
      );
      expect(find.text('sin'), findsOneWidget);

      semantics.dispose();
    },
  );

  testWidgets('DEG mode evaluates sin(90) as 1', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.byIcon(AppIcons.scientific));
    await tester.pumpAndSettle();

    await tester.tap(find.text('sin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('9'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('0'));
    await tester.pumpAndSettle();

    expect(displayResult('sin(90'), findsOneWidget);
    expect(displayResult('1'), findsOneWidget);
  });

  testWidgets('RAD mode leaves trig in radians', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.byIcon(AppIcons.scientific));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: find.byType(Keypad), matching: find.text('DEG')),
    );
    await tester.pumpAndSettle();
    expect(find.text('RAD'), findsNWidgets(2));

    await tester.tap(find.text('sin'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('0'));
    await tester.pumpAndSettle();

    expect(displayResult('sin(30'), findsOneWidget);
    expect(displayResult('−0.988031624092862'), findsOneWidget);
  });

  testWidgets('completed calculation is recorded in history', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: const CalculatorScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('+'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('='));
    await tester.pumpAndSettle();

    final history = container.read(historyProvider);
    expect(history, hasLength(1));
    expect(history.first.expression, '2+3');
    expect(history.first.result, '5');
  });

  testWidgets(
    'after = a digit starts a new expression and an operator continues',
    (tester) async {
      await pumpScreen(tester);

      await tester.tap(find.text('2'));
      await tester.tap(find.text('+'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text('='));
      await tester.pumpAndSettle();
      expect(displayResult('5'), findsOneWidget);

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();
      expect(displayResult('1'), findsOneWidget);
      expect(displayResult('51'), findsNothing);
    },
  );

  testWidgets('an operator after = continues from the result', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('2'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('='));
    await tester.pumpAndSettle();

    await tester.tap(find.text('+'));
    await tester.tap(find.text('4'));
    await tester.pumpAndSettle();
    expect(displayResult('5+4'), findsOneWidget);
  });
}
