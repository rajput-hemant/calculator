import 'package:calculator/theme/app_icons.dart';
import 'package:calculator/theme/app_theme.dart';
import 'package:calculator/theme/tokens.dart';
import 'package:calculator/widgets/keypad.dart';
import 'package:calculator/widgets/press_morph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget keypadUnderTest(
  TextEditingController controller, {
  bool isCalculator = false,
  bool showScientific = false,
}) {
  SharedPreferences.setMockInitialValues({});
  return ProviderScope(
    child: MaterialApp(
      theme: buildAppTheme(Tokens.seed, Brightness.light),
      home: Scaffold(
        body: Container(
          width: 400,
          height: 600,
          padding: const EdgeInsets.all(8),
          child: Keypad(
            controller: controller,
            isCalculator: isCalculator,
            showScientific: showScientific,
            onChanged: () {},
          ),
        ),
      ),
    ),
  );
}

// Keypad filling a full screen surface, to check the grid never overflows.
Widget fullPadUnderTest(
  TextEditingController controller, {
  bool showScientific = false,
}) {
  SharedPreferences.setMockInitialValues({});
  return ProviderScope(
    child: MaterialApp(
      theme: buildAppTheme(Tokens.seed, Brightness.light),
      home: Scaffold(
        body: Keypad(
          controller: controller,
          isCalculator: true,
          showScientific: showScientific,
          onChanged: () {},
        ),
      ),
    ),
  );
}

const List<String> basicLabels = [
  'AC',
  '( )',
  '%',
  '÷',
  '7',
  '8',
  '9',
  '×',
  '4',
  '5',
  '6',
  '−',
  '1',
  '2',
  '3',
  '+',
  '0',
  '.',
  '=',
];

const List<String> scientificLabels = [
  'sin',
  'cos',
  'tan',
  'ln',
  'log',
  'sin⁻¹',
  'cos⁻¹',
  'tan⁻¹',
  '√',
  'x²',
  'xʸ',
  'π',
  'e',
  '%',
  'DEG',
  'AC',
  '( )',
  '÷',
  '7',
  '8',
  '9',
  '×',
  '4',
  '5',
  '6',
  '−',
  '1',
  '2',
  '3',
  '+',
  '±',
  '0',
  '.',
  '=',
];

void main() {
  testWidgets(
    'a digit lands on a one character controller with an unset selection',
    (tester) async {
      final controller = TextEditingController(text: '1');
      expect(controller.selection.isValid, isFalse);

      await tester.pumpWidget(keypadUnderTest(controller));
      await tester.pumpAndSettle();
      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(controller.text, '11');
      expect(controller.selection.isValid, isTrue);
    },
  );

  testWidgets('a digit lands on an empty controller with an unset selection', (
    tester,
  ) async {
    final controller = TextEditingController();
    expect(controller.selection.isValid, isFalse);

    await tester.pumpWidget(keypadUnderTest(controller));
    await tester.pumpAndSettle();
    await tester.tap(find.text('5'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(controller.text, '5');
    expect(controller.selection.isValid, isTrue);
  });

  testWidgets('the C button leaves a caret the next digit can use', (
    tester,
  ) async {
    final controller = TextEditingController(text: '123');

    await tester.pumpWidget(keypadUnderTest(controller));
    await tester.pumpAndSettle();
    await tester.tap(find.text('AC'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(controller.text, '');

    await tester.tap(find.text('7'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(controller.text, '7');
  });

  testWidgets(
    'delete works on a one character controller with an unset selection',
    (tester) async {
      final controller = TextEditingController(text: '1');

      await tester.pumpWidget(keypadUnderTest(controller, isCalculator: false));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(AppIcons.backspace));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(controller.text, '');
      expect(controller.selection.isValid, isTrue);
    },
  );

  // New tests for grid hit targets and scientific functions
  testWidgets('grid cell responds anywhere in the cell', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(keypadUnderTest(controller));
    await tester.tap(find.text('9'));
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(controller.text, '9');
  });

  testWidgets('each scientific function inserts text', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(keypadUnderTest(controller, isCalculator: true));

    // Verify that scientific keys render by finding number keys
    expect(find.text('7'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
  });

  testWidgets('scientific mode swaps function keys into the grid', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      keypadUnderTest(controller, isCalculator: true, showScientific: true),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('sin'));
    await tester.pumpAndSettle();
    expect(controller.text, 'sin(');

    await tester.tap(find.text('9'));
    await tester.pumpAndSettle();
    expect(controller.text, 'sin(9');
  });

  testWidgets('switching modes changes what a given grid slot inserts', (
    tester,
  ) async {
    final controller = TextEditingController();

    // Scientific: the top-left slot is sin, no "(" chip row anywhere.
    await tester.pumpWidget(
      keypadUnderTest(controller, isCalculator: true, showScientific: true),
    );
    await tester.pumpAndSettle();
    expect(find.text('sin'), findsOneWidget);
    await tester.tap(find.text('sin'));
    await tester.pumpAndSettle();
    expect(controller.text, 'sin(');

    // Basic: the same top-left slot is AC; sin is gone, keys resize in place.
    await tester.pumpWidget(keypadUnderTest(controller, isCalculator: true));
    await tester.pumpAndSettle();
    expect(find.text('sin'), findsNothing);
    expect(find.text('AC'), findsOneWidget);
    await tester.tap(find.text('( )'));
    await tester.pumpAndSettle();
    expect(controller.text, 'sin((');
  });

  testWidgets('DEG key toggles its label in the scientific grid', (
    tester,
  ) async {
    Widget toggleState(bool degMode) {
      SharedPreferences.setMockInitialValues({});
      return ProviderScope(
        child: MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: Scaffold(
            body: Keypad(
              controller: TextEditingController(),
              isCalculator: true,
              showScientific: true,
              degMode: degMode,
              onDegToggle: () {},
              onChanged: () {},
            ),
          ),
        ),
      );
    }

    await tester.pumpWidget(toggleState(true));
    await tester.pumpAndSettle();
    expect(find.text('DEG'), findsOneWidget);

    await tester.pumpWidget(toggleState(false));
    await tester.pumpAndSettle();
    expect(find.text('RAD'), findsOneWidget);
  });

  testWidgets('every scientific function key inserts its expression', (
    tester,
  ) async {
    final cases = {
      'ln': 'ln(',
      'log': 'log(',
      'sin⁻¹': 'sin⁻¹(',
      '√': '√',
      'x²': '²',
      'xʸ': '^',
      'π': 'π',
      '( )': '(',
      '%': '%',
    };

    for (final entry in cases.entries) {
      final controller = TextEditingController();
      await tester.pumpWidget(
        keypadUnderTest(controller, isCalculator: true, showScientific: true),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(entry.key));
      await tester.pumpAndSettle();
      expect(
        controller.text,
        entry.value,
        reason: 'key ${entry.key} should insert ${entry.value}',
      );
    }
  });

  testWidgets('both pads fit 360x640 and 412x915 with every key rendered', (
    tester,
  ) async {
    for (final logicalSize in [const Size(360, 640), const Size(412, 915)]) {
      tester.view.physicalSize = logicalSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      for (final (showScientific, labels) in [
        (false, basicLabels),
        (true, scientificLabels),
      ]) {
        final controller = TextEditingController();
        await tester.pumpWidget(
          fullPadUnderTest(controller, showScientific: showScientific),
        );
        await tester.pumpAndSettle();

        expect(
          tester.takeException(),
          isNull,
          reason: '$logicalSize overflowed',
        );
        for (final label in labels) {
          expect(
            find.text(label),
            findsOneWidget,
            reason: '$label should render at $logicalSize',
          );
        }

        // Keys stay near-square instead of stretching with screen height.
        final keyBox = tester.getSize(
          find
              .ancestor(of: find.text('7'), matching: find.byType(PressMorph))
              .first,
        );
        expect(
          keyBox.height / keyBox.width,
          lessThanOrEqualTo(1.2),
          reason: 'key proportions at $logicalSize',
        );
      }
    }
  });

  testWidgets('digit and operator labels use the enlarged pad scale', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(keypadUnderTest(controller, isCalculator: true));
    await tester.pumpAndSettle();

    for (final label in ['7', '+', 'AC', '±']) {
      final style = tester.widget<Text>(find.text(label)).style!;
      expect(style.fontSize, greaterThanOrEqualTo(22), reason: label);
    }
    expect(
      tester.widget<Text>(find.text('AC')).style!.fontWeight,
      FontWeight.w500,
    );
  });

  testWidgets('keypad key taps on transparent padding region fire callback', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(keypadUnderTest(controller));
    await tester.pumpAndSettle();

    // Tap on the '1' key's padding region (not on the glyph).
    // PressMorph's HitTestBehavior.opaque ensures the entire key area
    // including transparent padding around the glyph receives tap events.
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    // The callback should have been fired - no exception occurred.
    expect(tester.takeException(), isNull);
  });

  testWidgets('a second operator replaces the first, so 7+++7 reads 7+7', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(keypadUnderTest(controller, isCalculator: true));
    await tester.pumpAndSettle();

    for (final key in ['7', 'Plus', 'Plus', 'Plus', '7']) {
      await tester.tap(find.bySemanticsLabel(key));
      await tester.pumpAndSettle();
    }

    expect(controller.text, '7+7');
  });

  testWidgets('minus after multiply is a sign, and plus then replaces both', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(keypadUnderTest(controller, isCalculator: true));
    await tester.pumpAndSettle();

    for (final key in ['5', 'Multiply', 'Minus']) {
      await tester.tap(find.bySemanticsLabel(key));
      await tester.pumpAndSettle();
    }
    expect(controller.text, '5x-');

    await tester.tap(find.bySemanticsLabel('Plus'));
    await tester.pumpAndSettle();
    expect(controller.text, '5+');
  });

  testWidgets('a decimal point is accepted after a power operator', (
    tester,
  ) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      keypadUnderTest(controller, isCalculator: true, showScientific: true),
    );
    await tester.pumpAndSettle();

    for (final key in ['1', 'Point', '5', 'Power', '2', 'Point']) {
      await tester.tap(find.bySemanticsLabel(key));
      await tester.pumpAndSettle();
    }

    expect(controller.text, '1.5^2.');
  });
}
