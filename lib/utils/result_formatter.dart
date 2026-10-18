/// Formats a parser result the way Google and Apple Calculator do: rounded to
/// 15 significant digits, which clears float noise without truncating exact
/// long integers.
String formatResult(String result) {
  final value = double.tryParse(result);

  // Dart's toString only emits "e" for |value| >= 1e21 (where toStringAsFixed
  // throws) or < 1e-6 (where fixed decimals would lose information), so those
  // results are kept exactly as produced.
  if (value == null || !value.isFinite || result.contains("e")) {
    return result.endsWith(".0")
        ? result.substring(0, result.length - 2)
        : result;
  }

  var text = value.toStringAsPrecision(15);

  // toStringAsPrecision can switch to exponent form where toString did not, so
  // fall back to the plain result rather than formatting the exponent by hand.
  if (text.contains("e")) return result;

  if (text.contains(".")) {
    text = text.replaceAll(RegExp(r'0+$'), "");
    if (text.endsWith(".")) text = text.substring(0, text.length - 1);
  }
  return text;
}
