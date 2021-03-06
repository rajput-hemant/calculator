import 'dart:developer';

class CalculatorBrain {
  String output = '0';
  String _output = '0';

  dynamic num1 = 0;
  dynamic num2 = 0;

  String operator = '';
  String resultOperationText = '0';
  bool isPressedPercentageButton = true;

  String buttonPressed(String buttonText) {
    if (buttonText == 'AC') {
      output = '0';
      _output = '0';
      num1 = 0;
      num2 = 0;
      operator = '';
      resultOperationText = '0';
      isPressedPercentageButton = true;
      return output;
    } else if (buttonText == '+/-') {
      isPressedPercentageButton = true;
      if (_output == '0') {
        _output = '-';
        output = _output;
        resultOperationText = output;
      } else if (_output.contains('-', 0)) {
        _output = _output.substring(1, _output.length);
        output = _output;
        resultOperationText = output;
      } else {
        _output = '-$_output';
        output = _output;
        resultOperationText = output;
      }
      return output;
    } else if (buttonText == '%') {
      if (isPressedPercentageButton) {
        if (output.contains('.')) {
          num1 = double.parse(output);
        } else {
          num1 = int.parse(output);
        }
        _output = (num1 / 100).toString();
        output = _output;
        _output = '';
        num1 = 0;
        resultOperationText = output;
        return output;
      }
    } else if (buttonText == '⌫') {
      if (_output != '' && _output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else if (_output.length == 1) {
        _output = '0';
      }
      output = _output;
      resultOperationText = output;
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == '÷') {
      if (output.contains('.')) {
        num1 = double.parse(output);
      } else {
        num1 = int.parse(output);
      }
      operator = buttonText;
      resultOperationText = operator;
      isPressedPercentageButton = false;
      log(operator);
      _output = "";
    } else if (buttonText == '.') {
      if (_output.contains('.')) {
        _output = _output;
        output = _output;
        resultOperationText = output;
      } else {
        _output = _output + buttonText;
        output = _output;
        if (resultOperationText == '0') resultOperationText = '';
        resultOperationText = output;
      }
    } else if (buttonText == '=') {
      isPressedPercentageButton = true;
      if (output.contains('.')) {
        num2 = double.parse(output);
      } else {
        num2 = int.parse(output);
      }

      if (operator == '+') _output = (num1 + num2).toString();
      if (operator == '-') _output = (num1 - num2).toString();
      if (operator == 'x') _output = (num1 * num2).toString();
      if (operator == '÷') _output = (num1 / num2).toString();

      num1 = 0;
      num2 = 0;
      operator = '';
      if (_output.contains('.')) {
        output = double.parse(_output).toStringAsFixed(2);
      } else {
        output = _output;
      }
      resultOperationText = '';
      _output = '';
    } else {
      if (_output == '0' || _output == '0.0') _output = '';
      if (resultOperationText == '0' || resultOperationText == '0.0') {
        resultOperationText = '';
      }
      _output = _output + buttonText;
      output = _output;
      resultOperationText = resultOperationText + buttonText;
    }
    log(output);
    return output;
  }
}
