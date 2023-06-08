import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/keypad.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _expressionController = TextEditingController();

  String _output = "";

  void parseExpression(String expression) {
    setState(() {
      _expressionController.text = _output;

      _output = "";
    });
  }

  void parseExpressionOnChange(String expression) {
    if (expression.isEmpty) {
      setState(() => _output = "");
    }

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

  @override
  void dispose() {
    _expressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
      //     child: Image.asset("assets/images/app_icon.png"),
      //   ),
      //   title: const Text(
      //     'Calculator',
      //     style: TextStyle(
      //       fontSize: 24,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.grid_4x4),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.more_vert),
      //     ),
      //   ],
      // ),
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
                    enableInteractiveSelection: false,
                    keyboardType: TextInputType.none,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 48),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(fontSize: 48),
                    ),
                  ),
                  Text(
                    _output,
                    style: const TextStyle(),
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
              onChanged: () =>
                  parseExpressionOnChange(_expressionController.text),
              onPressed: () => parseExpression(_expressionController.text),
            ),
          ),
        ],
      ),
    );
  }
}
