import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/preferences_provider.dart';
import '../utils/utils.dart';
import '../widgets/keypad.dart';
import '../widgets/main_appbar.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _expressionController = TextEditingController();

  String _output = "";
  double _fontSize = 48;

  void parseExpression(String expression) {
    setState(() {
      _expressionController.text = _output;

      _output = "";
    });

    // set cursor to the end of the expression
    _expressionController.selection = TextSelection.fromPosition(
      TextPosition(offset: _expressionController.text.length),
    );
  }

  void parseExpressionOnChange(String expression) {
    if (expression.isEmpty) {
      setState(() => _output = "");
    }
    // replace sin-1, cos-1, tan-1 with arcsin, arccos, arctan
    expression = expression.replaceAll("sin\u207B\u00B9", "arcsin");
    expression = expression.replaceAll("cos\u207B\u00B9", "arccos");
    expression = expression.replaceAll("tan\u207B\u00B9", "arctan");

    // replace x² with x^2
    expression = expression.replaceAll("\u00B2", "^2");

    // replace π with *3.141592653589793
    expression = expression.replaceAll("π", "*3.141592653589793");

    // replace x with *
    expression = expression.replaceAll("x", "*");

    // replace √ with sqrt
    expression = expression.replaceAll("√", "sqrt(");

    // update the expression to always use base 10 log
    expression = expression.replaceAllMapped(
        RegExp(r'log\s*\(\s*([^,]+)\s*\)?'),
        (match) => 'log(${match.group(1)}, 10)');

    String result = MathParser.parseExpression(expression);

    // if expression is invalid, return
    if (result == "Expression Error") {
      return;
    }

    // if expression contains only numbers, return
    if (RegExp(r'^[\d.]+$').hasMatch(expression)) {
      return;
    }

    // if resulte ends with .0, remove it
    if (result.endsWith(".0")) {
      result = result.substring(0, result.length - 2);
    }

    setState(() => _output = result);
  }

  void setFontSize() {
    setState(() {
      if (_expressionController.text.length > 18) {
        _fontSize = 32;
      } else if (_expressionController.text.length > 12) {
        _fontSize = 36;
      } else {
        _fontSize = 48;
      }
    });
  }

  @override
  void dispose() {
    _expressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTabView = ref.watch(prefrencesProvider).tabView;

    return Scaffold(
      appBar: isTabView ? null : const MainAppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    autofocus: true,
                    controller: _expressionController,
                    keyboardType: TextInputType.none,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: _fontSize),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Keypad(
              controller: _expressionController,
              isCalculator: true,
              onChanged: () {
                parseExpressionOnChange(_expressionController.text);
                setFontSize();
              },
              onPressed: () {
                parseExpression(_expressionController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
