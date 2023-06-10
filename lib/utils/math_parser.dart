import 'package:math_expressions/math_expressions.dart';

class MathParser {
  static Parser p = Parser();
  static ContextModel cm = ContextModel();

  static int _countUnclosedParenthesis(String expression) {
    int count = 0;

    for (var element in expression.runes) {
      var char = String.fromCharCode(element);

      if (char == "(") {
        count++;
      } else if (char == ")") {
        count--;
      }
    }
    return count;
  }

  // parse the math expression like 2+2 or sin(90) and return the result
  static String parseExpression(String expression) {
    try {
      int count = _countUnclosedParenthesis(expression);
      Expression exp = p.parse("$expression${")" * count}");

      return exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      return "Expression Error";
    }
  }
}
