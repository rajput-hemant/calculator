// Only an x between operands is multiplication; keeps the x in names like exp.
final RegExp _times = RegExp(r'(?<=[\d.)%πe²\s])x(?=[\d.(\s√πe\-a-z])');

/// Maps the ASCII operators stored in expressions to typographic glyphs, for
/// display only.
String displayGlyphs(String expression) => expression
    .replaceAll(_times, '×')
    .replaceAll('/', '÷')
    .replaceAll('-', '−');
