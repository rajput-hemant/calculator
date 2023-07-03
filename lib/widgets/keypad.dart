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
  bool _showScientific = false;
  bool _enableInput = true;
  bool _showInverse = false;

  /// Insert the given text into the controller at the current cursor position
  /// and update the cursor position after the inserted text.
  void insertText(String text) {
    if (!widget.isCalculator) {
      showSnackbar();
    }

    if (!_enableInput) {
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
        SnackBar(
          content: const Text(
            "Maximum digits (15) reached.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(milliseconds: 500),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      setState(() => _enableInput = false);
    } else {
      setState(() => _enableInput = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          if (_showScientific)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButton(
                    isScientic: _showScientific,
                    text: "deg",
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    onPressed: () {},
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: _showInverse ? "REG" : "INV",
                    onPressed: () {
                      setState(() => _showInverse = !_showInverse);
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: _showInverse ? "sin\u207B\u00B9" : "sin",
                    onPressed: () {
                      insertText("sin${_showInverse ? "\u207B\u00B9" : ""}(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: _showInverse ? "cos\u207B\u00B9" : "cos",
                    onPressed: () {
                      insertText("cos${_showInverse ? "\u207B\u00B9" : ""}(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: _showInverse ? "tan\u207B\u00B9" : "tan",
                    onPressed: () {
                      insertText("tan${_showInverse ? "\u207B\u00B9" : ""}(");
                      widget.onChanged();
                    },
                  ),
                ],
              ),
            ),
          if (_showScientific)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButton(
                    isScientic: _showScientific,
                    text: _showInverse ? "x\u00B2" : "\u221Ax",
                    onPressed: () {
                      insertText(_showInverse ? "\u00B2" : "\u221A");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: _showInverse ? "10\u0302" : "lg",
                    onPressed: () {
                      insertText(_showInverse ? "10^" : "log(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: "ln",
                    onPressed: () {
                      insertText("ln(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    text: "(",
                    onPressed: () {
                      insertText("(");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
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
                  if (_showScientific)
                    RoundButton(
                      isScientic: _showScientific,
                      text: "x\u207F",
                      onPressed: () {
                        insertText("^");
                        widget.onChanged();
                      },
                    ),
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.c,
                    iconColor: Theme.of(context).colorScheme.errorContainer,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.percent,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("%");
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.deleteLeft,
                    iconColor: Theme.of(context).colorScheme.error,
                    onPressed: () {
                      removeLastCharacter();
                      widget.onChanged();
                    },
                  ),
                  RoundButton(
                    isScientic: _showScientific,
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
                if (_showScientific)
                  RoundButton(
                    isScientic: _showScientific,
                    text: "x!",
                    onPressed: () {
                      insertText("!");
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.seven,
                  onPressed: () {
                    insertText("7");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.eight,
                  onPressed: () {
                    insertText("8");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.nine,
                  onPressed: () {
                    insertText("9");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.xmark,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      insertText("x");
                      widget.onChanged();
                    },
                  ),
                if (!widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.c,
                    iconColor: Theme.of(context).colorScheme.errorContainer,
                    backgroundColor: Theme.of(context).colorScheme.error,
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
                if (_showScientific)
                  RoundButton(
                    isScientic: _showScientific,
                    text: "1/x",
                    onPressed: () {
                      insertText("1/");
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.four,
                  onPressed: () {
                    insertText("4");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.five,
                  onPressed: () {
                    insertText("5");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.six,
                  onPressed: () {
                    insertText("6");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
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
                if (_showScientific)
                  RoundButton(
                    isScientic: _showScientific,
                    text: "\u03C0",
                    onPressed: () {
                      insertText("\u03C0");
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.three,
                  onPressed: () {
                    insertText("3");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.two,
                  onPressed: () {
                    insertText("2");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.one,
                  onPressed: () {
                    insertText("1");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
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
                    isScientic: _showScientific,
                    icon: _showScientific
                        ? FontAwesomeIcons.downLeftAndUpRightToCenter
                        : FontAwesomeIcons.upRightAndDownLeftFromCenter,
                    iconColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      setState(() {
                        _showScientific = !_showScientific;
                      });
                    },
                  ),
                if (!widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
                    text: "00",
                    textStyle: const TextStyle(fontSize: 30),
                    onPressed: () {
                      insertText("00");
                      widget.onChanged();
                    },
                  ),
                if (_showScientific)
                  RoundButton(
                    isScientic: _showScientific,
                    text: "e",
                    onPressed: () {
                      insertText("e");
                      widget.onChanged();
                    },
                  ),
                RoundButton(
                  isScientic: _showScientific,
                  icon: FontAwesomeIcons.zero,
                  onPressed: () {
                    insertText("0");
                    widget.onChanged();
                  },
                ),
                RoundButton(
                  isScientic: _showScientific,
                  text: ".",
                  textStyle: TextStyle(fontSize: _showScientific ? 20 : 40),
                  onPressed: () {
                    // check if the number till the last operator has a dot
                    final String text = widget.controller.text;

                    final int lastOperatorIndex =
                        text.lastIndexOf(RegExp(r"[+\-x/%]"));
                    final int lastDotIndex = text.lastIndexOf(".");
                    if (lastDotIndex > lastOperatorIndex) return;

                    insertText(".");
                    widget.onChanged();
                  },
                ),
                if (widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.equals,
                    iconColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: widget.onPressed,
                  ),
                if (!widget.isCalculator)
                  RoundButton(
                    isScientic: _showScientific,
                    icon: FontAwesomeIcons.deleteLeft,
                    iconColor: Theme.of(context).colorScheme.error,
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
