import 'package:flutter/widgets.dart';

// Assigning .text collapses the selection to -1, which crashes layout of an
// already-autofocused field, so set a full value with a valid caret instead.
void setTextKeepingCaret(TextEditingController controller, String text) {
  controller.value = TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: text.length),
  );
}

/// A controller whose initial text carries a valid caret at the end.
///
/// `TextEditingController(text: ...)` leaves the selection unset (-1) until the
/// field gains focus, which never happens for fields the keypad drives.
TextEditingController textEditingController([String text = ""]) {
  return TextEditingController(text: text)
    ..selection = TextSelection.collapsed(offset: text.length);
}

/// The caret an edit should use: the controller's selection when it is valid
/// and inside the text, otherwise the end of the text.
///
/// The selection is unset (-1) while no field is focused, so reading it
/// directly can hand `substring`/`replaceRange` an out of range offset.
int caretOffset(TextEditingController controller) {
  final textLength = controller.text.length;
  final selection = controller.selection;
  return selection.isValid && selection.start <= textLength
      ? selection.start
      : textLength;
}
