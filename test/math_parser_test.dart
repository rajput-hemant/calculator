import 'package:calculator/utils/math_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('log is base 10', () {
    expect(
      double.parse(MathParser.evaluate('log(100)', degrees: true)!),
      closeTo(2, 1e-9),
    );
  });

  test('percent divides by 100', () {
    expect(
      double.parse(MathParser.evaluate('50%', degrees: true)!),
      closeTo(0.5, 1e-9),
    );
  });

  test('square root binds to its operand only', () {
    expect(
      double.parse(MathParser.evaluate('√9+1', degrees: true)!),
      closeTo(4, 1e-9),
    );
  });

  test('inverse sine returns degrees', () {
    expect(
      double.parse(MathParser.evaluate('sin⁻¹(1)', degrees: true)!),
      closeTo(90, 1e-9),
    );
  });

  test('sine of 180 degrees is exactly zero', () {
    expect(MathParser.evaluate('sin(180)', degrees: true), '0');
  });

  test('a number before parentheses multiplies', () {
    expect(
      double.parse(MathParser.evaluate('2(3)', degrees: true)!),
      closeTo(6, 1e-9),
    );
  });

  test('division by zero is not a finite result', () {
    expect(MathParser.evaluate('1/0', degrees: true), isNull);
  });

  test('factorial', () {
    expect(double.parse(MathParser.evaluate('5!', degrees: true)!), 120);
    expect(double.parse(MathParser.evaluate('(2+1)!+1', degrees: true)!), 7);
  });

  test('percent of a base and as a plain fraction', () {
    double v(String e) => double.parse(MathParser.evaluate(e, degrees: true)!);
    expect(v('1000+10%'), closeTo(1100, 1e-9));
    expect(v('1000-10%'), closeTo(900, 1e-9));
    expect(v('1000x10%'), closeTo(100, 1e-9));
    expect(v('1000/10%'), closeTo(10000, 1e-9));
    expect(v('2+3x4+50%'), closeTo(21, 1e-9));
  });
}
