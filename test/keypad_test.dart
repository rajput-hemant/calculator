import 'package:calculator/widgets/keypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget keypadUnderTest(
  TextEditingController controller, {
  bool isCalculator = false,
}) {
  return MaterialApp(
    home: Scaffold(
      body: Keypad(
        controller: controller,
        isCalculator: isCalculator,
        onChanged: () {},
      ),
    ),
  );
}

void main() {
  testWidgets(
    'a digit lands on a one character controller with an unset selection',
    (tester) async {
      // TextEditingController(text:) leaves selection at -1, which used to
      // make substring(0, -1) throw "Not in inclusive range 0..1: -1".
      final controller = TextEditingController(text: '1');
      expect(controller.selection.isValid, isFalse);

      await tester.pumpWidget(keypadUnderTest(controller));
      await tester.tap(find.byIcon(FontAwesomeIcons.one.data));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(controller.text, '11');
      expect(controller.selection.isValid, isTrue);
    },
  );

  testWidgets(
    'a digit lands on an empty controller with an unset selection',
    (tester) async {
      // TextEditingController() also leaves selection at -1, which used to
      // throw "Only valid value is 0: -1".
      final controller = TextEditingController();
      expect(controller.selection.isValid, isFalse);

      await tester.pumpWidget(keypadUnderTest(controller));
      await tester.tap(find.byIcon(FontAwesomeIcons.five.data));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(controller.text, '5');
      expect(controller.selection.isValid, isTrue);
    },
  );

  testWidgets(
    'the C button leaves a caret the next digit can use',
    (tester) async {
      final controller = TextEditingController(text: '123');

      await tester.pumpWidget(keypadUnderTest(controller));
      await tester.tap(find.byIcon(FontAwesomeIcons.c.data));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(controller.text, '0');

      await tester.tap(find.byIcon(FontAwesomeIcons.seven.data));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(controller.text, '07');
    },
  );

  testWidgets(
    'delete works on a one character controller with an unset selection',
    (tester) async {
      final controller = TextEditingController(text: '1');

      await tester.pumpWidget(keypadUnderTest(controller));
      await tester.tap(find.byIcon(FontAwesomeIcons.deleteLeft.data));
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(controller.text, '');
      expect(controller.selection.isValid, isTrue);
    },
  );
}
