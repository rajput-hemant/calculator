import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/utils/text_editing.dart';

void main() {
  testWidgets('setTextKeepingCaret leaves a valid caret at the end of the text',
      (tester) async {
    final controller = TextEditingController(text: 'ab');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextField(
            controller: controller,
            autofocus: true,
            readOnly: true,
          ),
        ),
      ),
    );

    setTextKeepingCaret(controller, '12.34');

    expect(controller.text, '12.34');
    expect(controller.selection.isValid, isTrue);
    expect(controller.selection.baseOffset, controller.text.length);

    await tester.pump();
  });
}
