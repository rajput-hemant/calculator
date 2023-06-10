import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'round_button.dart';

class Keypad extends StatefulWidget {
  const Keypad({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onPressed,
    this.isCalculator = false,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;
  final VoidCallback? onPressed;
  final bool isCalculator;

  @override
  State<Keypad> createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  final IconData period = const IconDataSolid(0x2e);

  bool showScientific = false;
  bool enableInput = true;

  /// Insert the given text into the controller at the current cursor position
  /// and update the cursor position after the inserted text.
  void insertText(String text) {
    if (!widget.isCalculator) {
      showSnackbar();
    }

    if (!enableInput) {
      return;
    }
    // get the current cursor position
    final cursorPosition = widget.controller.selection.start;
    // update the text in the controller with the given text at the current cursor position
    final updatedText =
        '${widget.controller.text.substring(0, cursorPosition)}$text${widget.controller.text.substring(cursorPosition)}';

    // set the updated text in the controller
    // and update the cursor position after the inserted text
    widget.controller.value = TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: cursorPosition + text.length),
    );
  }

  void removeLastCharacter() {
    // Get the current cursor position
    final cursorPosition = widget.controller.selection.start;

    // Get the current text in the controller
    final currentText = widget.controller.text;

    // Remove the character before the cursor position
    final updatedText = currentText.replaceRange(
        cursorPosition > 0 ? cursorPosition - 1 : 0, cursorPosition, '');

    // Set the updated text in the controller
    widget.controller.value =
        widget.controller.value.copyWith(text: updatedText);

    // Update the cursor position after the inserted text
    final updatedCursorPosition = cursorPosition > 0 ? cursorPosition - 1 : 0;
    widget.controller.selection =
        TextSelection.collapsed(offset: updatedCursorPosition);
  }

  // show toast notification and disable input if length of text is > 15
  void showSnackbar() {
    if (widget.controller.text.length >= 15) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maximum digits(15) reached."),
          duration: Duration(milliseconds: 500),
        ),
      );
      setState(() => enableInput = false);
    } else {
      setState(() => enableInput = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
      ),
      child: Column(
        children: [
          if (showScientific)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButton(
                    isScientic: showScientific,
                    text: "rad",
                    onPressed: () {
                      insertText("");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "deg",
                    onPressed: () {
                      insertText("");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "sin",
                    // text: "sin\u207B\u00B9",
                    onPressed: () {
                      insertText("sin(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "cos",
                    // text: "cos\u207B\u00B9",
                    onPressed: () {
                      insertText("cos(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "tan",
                    // text: "tan\u207B\u00B9",
                    onPressed: () {
                      insertText("tan(");
                      widget.onChanged();
                    },
                  ),
                ],
              ),
            ),
          if (showScientific)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButton(
                    isScientic: showScientific,
                    text: "x\u207F",
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "lg",
                    onPressed: () {
                      insertText("log(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "ln",
                    onPressed: () {
                      insertText("%");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: "(",
                    onPressed: () {
                      insertText("(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    text: ")",
                    onPressed: () {
                      insertText(")");
                      widget.onChanged();
                    },
                  ),
                ],
              ),
            ),
          if (widget.isCalculator)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (showScientific)
                    RoundButton(
                      isScientic: showScientific,
                      text: "\u221Ax",
                      onPressed: () {
                        insertText("sqrt(");
                        widget.onChanged();
                      },
                    ),
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.c,
                    iconColor: Theme.of(context).colorScheme.error,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.percent,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("%");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.deleteLeft,
                    iconColor: Colors.red,
                    onPressed: () {
                      removeLastCharacter();
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.divide,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("/");
                      widget.onChanged();
                    },
                  ),
                ],
              ),
            ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showScientific)
                  RoundButton(
                    isScientic: showScientific,
                    text: "x!",
                    onPressed: () {
                      insertText("factorial(");
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.seven,
                  onPressed: () {
                    insertText("7");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.eight,
                  onPressed: () {
                    insertText("8");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.nine,
                  onPressed: () {
                    insertText("9");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.xmark,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("*");
                      widget.onChanged();
                    },
                  ),
                if (!widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.c,
                    iconColor: Theme.of(context).colorScheme.error,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged();
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showScientific)
                  RoundButton(
                    isScientic: showScientific,
                    text: "1/x",
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.four,
                  onPressed: () {
                    insertText("4");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.five,
                  onPressed: () {
                    insertText("5");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.six,
                  onPressed: () {
                    insertText("6");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.minus,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("-");
                      widget.onChanged();
                    },
                  ),
                if (!widget.isCalculator) const RoundButton()
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (showScientific)
                  RoundButton(
                    isScientic: showScientific,
                    text: "\u03C0",
                    onPressed: () {
                      insertText("pi");
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.three,
                  onPressed: () {
                    insertText("3");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.two,
                  onPressed: () {
                    insertText("2");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.one,
                  onPressed: () {
                    insertText("1");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.plus,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("+");
                      widget.onChanged();
                    },
                  ),
                if (!widget.isCalculator) const RoundButton(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: showScientific
                        ? FontAwesomeIcons.downLeftAndUpRightToCenter
                        : FontAwesomeIcons.upRightAndDownLeftFromCenter,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      setState(() {
                        showScientific = !showScientific;
                      });
                    },
                  ),
                if (!widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.zero,
                    onPressed: () {
                      insertText("00");
                      widget.onChanged();
                    },
                  ),
                if (showScientific)
                  RoundButton(
                    isScientic: showScientific,
                    text: "e",
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: showScientific,
                  icon: FontAwesomeIcons.zero,
                  onPressed: () {
                    insertText("0");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: showScientific,
                  icon: period,
                  onPressed: () {
                    if (!widget.controller.text.contains(".")) insertText(".");
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.equals,
                    iconColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: widget.onPressed,
                  ),
                if (!widget.isCalculator)
                  RoundButton(
                    isScientic: showScientific,
                    icon: FontAwesomeIcons.deleteLeft,
                    iconColor: Colors.red,
                    onPressed: () {
                      removeLastCharacter();
                      widget.onChanged();
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
