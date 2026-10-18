import 'package:calculator/utils/math_parser.dart';
import 'package:calculator/utils/result_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

String display(String typed) {
  final r = MathParser.evaluate(typed, degrees: true);
  return r == null ? 'Expression Error' : formatResult(r);
}

void main() {
  test("0.1+0.1+0.1 shows 0.3", () {
    expect(display("0.1+0.1+0.1"), "0.3");
  });

  test("0.1+0.2 shows 0.3", () {
    expect(display("0.1+0.2"), "0.3");
  });

  test("1000*0.1 shows 100", () {
    expect(display("1000x0.1"), "100");
  });

  test("1/3 shows 15 significant digits", () {
    expect(display("1/3"), "0.333333333333333");
  });

  test("2+3 shows 5, not 5.0", () {
    expect(display("2+3"), "5");
  });

  test("long integer 1234567890123 is not truncated", () {
    expect(display("1234567890123"), "1234567890123");
  });

  test("1/10000000 keeps its exponent form unchanged", () {
    expect(display("1/10000000"), "1e-7");
  });

  test("exact decimals are not inflated with float noise", () {
    expect(display("1.5x2"), "3");
    expect(display("0.25+0.25"), "0.5");
  });

  test("magnitude >= 1e21 falls back to toString and does not throw", () {
    final shown = display("99999999999999999999999");
    expect(shown, "1e+23");
  });

  test("non-finite results stay as produced", () {
    expect(formatResult("Infinity"), "Infinity");
  });
}
