import 'package:math_expressions/math_expressions.dart';

const _degToRad = '0.017453292519943295';
const _radToDeg = '57.29577951308232';

// Scientific notation, or the constant e; the first alternative keeps 1e-7.
final _eToken = RegExp(r'(\d[\d.]*)e([+\-]?\d+)|(?<![a-z])e(?![a-z])');
final _sqrtOperand = RegExp(r'√(\d[\d.]*)');
final _trigHead = RegExp(r'(?<![a-z])(sin|cos|tan|arcsin|arccos|arctan)\(');
// Juxtaposition like 2(3), 2sin(1) or (1)2 means multiplication.
final _implicitTimes = RegExp(
  r'(?<=[\d.)])(?=\(|(?!e[+\-]?\d)[a-z])|(?<=\))(?=[\d.])',
);

class MathParser {
  static final Parser _parser = Parser();
  static final ContextModel _context = ContextModel();

  /// Closes any unclosed parentheses so mid-typing previews see complete calls.
  static String closeParens(String expression) {
    var open = 0;
    for (final char in expression.split('')) {
      if (char == '(') {
        open++;
      } else if (char == ')') {
        open--;
      }
    }
    return open > 0 ? expression + ')' * open : expression;
  }

  /// Evaluates an expression as typed on the keypad (glyphs like x, ², π, √,
  /// %) and returns the raw result, or null when it is not a valid expression
  /// or not a finite number. [degrees] makes trig take and return degrees.
  static String? evaluate(String typed, {required bool degrees}) {
    var s = closeParens(typed)
        .replaceAll('sin⁻¹', 'arcsin')
        .replaceAll('cos⁻¹', 'arccos')
        .replaceAll('tan⁻¹', 'arctan')
        .replaceAll('²', '^2')
        .replaceAll('%', '*0.01')
        .replaceAll('π', '(3.141592653589793)')
        .replaceAll('x', '*')
        .replaceAll('±', '-')
        .replaceAll('log(', 'log(10,')
        .replaceAllMapped(
          _eToken,
          (m) =>
              m[1] == null ? '(2.718281828459045)' : '(${m[1]}*10^(${m[2]}))',
        )
        .replaceAllMapped(_sqrtOperand, (m) => 'sqrt(${m[1]})')
        .replaceAll('√', 'sqrt');
    if (degrees) s = _degreeTrig(s);
    s = s.replaceAll(_implicitTimes, '*');

    final result = _evaluate(s);
    // Trig on a rounded π leaves float noise, e.g. sin(180°) = 1.2e-16.
    if (result != null &&
        _trigHead.hasMatch(s) &&
        double.parse(result).abs() < 1e-12) {
      return '0';
    }
    return result;
  }

  static String? _evaluate(String expression) {
    try {
      final value = _parser
          .parse(closeParens(expression))
          .evaluate(EvaluationType.REAL, _context);
      return value is num && value.isFinite ? value.toString() : null;
    } catch (_) {
      return null;
    }
  }

  // Angles in degrees: wrap each trig argument, and each inverse result, with
  // the unit conversion. Arguments may nest, so match parentheses by depth.
  static String _degreeTrig(String s) {
    final head = _trigHead.firstMatch(s);
    if (head == null) return s;
    var depth = 1;
    var end = head.end;
    while (end < s.length && depth > 0) {
      if (s[end] == '(') {
        depth++;
      } else if (s[end] == ')') {
        depth--;
      }
      end++;
    }
    final fn = head[1]!;
    final arg = _degreeTrig(s.substring(head.end, end - 1));
    final call = fn.startsWith('arc')
        ? '($fn($arg)*$_radToDeg)'
        : '$fn(($arg)*$_degToRad)';
    return '${s.substring(0, head.start)}$call${_degreeTrig(s.substring(end))}';
  }
}
