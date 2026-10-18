import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/history_entry.dart';
import '../provider/history_provider.dart';
import '../provider/pending_insert_provider.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/math_parser.dart';
import '../utils/result_formatter.dart';
import '../utils/text_editing.dart';
import '../widgets/calc_display.dart';
import '../widgets/keypad.dart';
import '../widgets/main_appbar.dart';

// Keeps the expression readable when the keypad grows on tall screens.
const double _minDisplayHeight = 160;

final RegExp _plainNumber = RegExp(r'^[\d.]+$');
final RegExp _logCall = RegExp(r'log\s*\(\s*([^,]+)\s*\)?');
final RegExp _trigCall = RegExp(r'\b(sin|cos|tan)\(([^()]*)\)');

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _expressionController = textEditingController();

  String _output = "";
  bool _showScientific = false;
  bool _degMode = true; // true = degrees, false = radians
  bool _justEvaluated = false;

  /// Equations already evaluated this session, oldest first.
  final List<String> _tape = [];

  /// The stacked equation being edited in place, if any. The front expression
  /// waits in [_draft] meanwhile.
  int? _editing;
  ({String text, bool evaluated}) _draft = (text: '', evaluated: false);

  void _insertTextAtCaret(String text) {
    final cursorPosition = caretOffset(_expressionController);
    final updatedText =
        '${_expressionController.text.substring(0, cursorPosition)}$text${_expressionController.text.substring(cursorPosition)}';
    _expressionController.value = TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: cursorPosition + text.length),
    );
    _edited();
  }

  // Edits a stacked equation in its slot; = writes it back there, without
  // touching history or growing the stack.
  void _recall(int index) {
    if (index == _editing) return;
    if (_editing == null) {
      _draft = (text: _expressionController.text, evaluated: _justEvaluated);
    }
    _editing = index;
    setTextKeepingCaret(_expressionController, _tape[index]);
    _edited();
  }

  void _finishEditing() {
    final index = _editing!;
    final expression = _expressionController.text;
    setState(() {
      if (expression.isNotEmpty && _output.isNotEmpty) {
        _tape[index] = expression;
      }
      _editing = null;
      setTextKeepingCaret(_expressionController, _draft.text);
    });
    _edited();
    if (_draft.evaluated) {
      setState(() {
        _output = '';
        _justEvaluated = true;
      });
    }
  }

  void _edited() {
    setState(() => _justEvaluated = false);
    parseExpressionOnChange(_expressionController.text);
  }

  void _equals() {
    if (_editing != null) return _finishEditing();
    final expression = _expressionController.text;
    if (expression.isEmpty || _output.isEmpty) return;
    ref
        .read(historyProvider.notifier)
        .add(
          HistoryEntry(
            expression: expression,
            result: _output,
            timestamp: DateTime.now(),
          ),
        );
    _commitResult();
  }

  void _commitResult() {
    setState(() {
      _tape.add(_expressionController.text);
      setTextKeepingCaret(_expressionController, _output);
      _output = "";
      _justEvaluated = true;
    });
  }

  void parseExpressionOnChange(String expression) {
    if (expression.isEmpty) {
      setState(() => _output = "");
      return;
    }

    // Close open parentheses so mid-typing previews see complete calls.
    var open = 0;
    for (var code in expression.runes) {
      final char = String.fromCharCode(code);
      if (char == "(") {
        open++;
      } else if (char == ")") {
        open--;
      }
    }
    final balanced = expression + ")" * (open < 0 ? 0 : open);

    String transformed = balanced;
    transformed = transformed.replaceAll("sin⁻¹", "arcsin");
    transformed = transformed.replaceAll("cos⁻¹", "arccos");
    transformed = transformed.replaceAll("tan⁻¹", "arctan");
    transformed = transformed.replaceAll("²", "^2");
    transformed = transformed.replaceAll("π", "*3.141592653589793");
    transformed = transformed.replaceAll("x", "*");
    transformed = transformed.replaceAll("±", "-");
    transformed = transformed.replaceAll("√", "sqrt(");
    transformed = transformed.replaceAllMapped(
      _logCall,
      (match) => 'log(${match.group(1)}, 10)',
    );

    // Angles are typed in degrees and converted to radians for the parser.
    if (_degMode) {
      transformed = transformed.replaceAllMapped(
        _trigCall,
        (match) => '${match.group(1)}(${match.group(2)}*0.017453292519943295)',
      );
    }

    String result = MathParser.parseExpression(transformed);

    if (result == "Expression Error") {
      return;
    }

    if (_plainNumber.hasMatch(expression)) {
      return;
    }

    result = formatResult(result);
    setState(() => _output = result);
  }

  @override
  void dispose() {
    _expressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(pendingInsertProvider, (previous, next) {
      if ((next ?? '').isNotEmpty) {
        _insertTextAtCaret(next!);
        ref.read(pendingInsertProvider.notifier).setValue(null);
      }
    });

    return Scaffold(
      backgroundColor: Palette.of(context).bg,
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        showScientific: _showScientific,
        onScientificToggle: () =>
            setState(() => _showScientific = !_showScientific),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(top: Tokens.topBarInset(context)),
          child: LayoutBuilder(
            builder: (context, box) {
              final display = CalcDisplay(
                controller: _expressionController,
                result: _output,
                tape: _tape,
                editing: _editing,
                onTapeTap: _recall,
                evaluated: _justEvaluated,
                angleUnit: _showScientific ? (_degMode ? 'DEG' : 'RAD') : null,
              );
              final keypad = Keypad(
                controller: _expressionController,
                isCalculator: true,
                showScientific: _showScientific,
                degMode: _degMode,
                justEvaluated: () => _justEvaluated,
                onDegToggle: () => setState(() => _degMode = !_degMode),
                onChanged: _edited,
                onPressed: _equals,
                onClear: () => setState(() {
                  _tape.clear();
                  _editing = null;
                }),
              );
              if (box.maxWidth > box.maxHeight) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: display),
                    SizedBox(
                      width: box.maxWidth * (_showScientific ? 0.7 : 0.5),
                      child: keypad,
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  Expanded(child: display),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: math.max(0, box.maxHeight - _minDisplayHeight),
                    ),
                    child: keypad,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
