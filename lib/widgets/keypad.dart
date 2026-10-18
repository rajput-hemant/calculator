import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/preferences_provider.dart';
import '../theme/app_icons.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/text_editing.dart';
import 'press_morph.dart';

// Inserting one of these after a result continues the calculation; anything
// else starts a fresh expression.
const _continuations = {'+', '-', 'x', '/', '%', '^', '²', '±'};

final _operatorChar = RegExp(r'[+\-x/%]');

class Keypad extends ConsumerStatefulWidget {
  const Keypad({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onPressed,
    this.isCalculator = false,
    this.showScientific = false,
    this.degMode = true,
    this.justEvaluated,
    this.onDegToggle,
    this.onClear,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;
  final VoidCallback? onPressed;
  final bool isCalculator;
  final bool showScientific;
  final bool degMode;

  /// Asked at press time: true while the expression is a result from `=`, so
  /// a digit or function starts over.
  final bool Function()? justEvaluated;
  final VoidCallback? onDegToggle;

  /// AC was pressed; the expression is already cleared.
  final VoidCallback? onClear;

  @override
  ConsumerState<Keypad> createState() => _KeypadState();
}

class _KeypadState extends ConsumerState<Keypad> {
  static const double _sidePadding = 24;
  static const double _bottomPadding = 12;
  static const double _basicGap = 14;
  static const double _compactGap = 12;
  static const double _compactKeyHeight = 60;
  static const double _stripKeyHeight = 48;
  static const double _stripGap = 8;
  static const double _bandGap = 16;
  static const double _maxKeyWidth = 88;

  bool get _justEvaluated => widget.justEvaluated?.call() ?? false;

  // Medium is the keyboard tap. On Samsung, light, heavy and selection
  // haptics are 1 ms pulses, too short to feel.
  void _haptic() {
    if (ref.read(prefrencesProvider).hapticsEnabled) {
      HapticFeedback.mediumImpact();
    }
  }

  void insertText(String text) {
    _haptic();
    final fresh = _justEvaluated && !_continuations.contains(text);
    final current = fresh ? '' : widget.controller.text;
    final cursor = fresh ? 0 : caretOffset(widget.controller);
    widget.controller.value = TextEditingValue(
      text: '${current.substring(0, cursor)}$text${current.substring(cursor)}',
      selection: TextSelection.collapsed(offset: cursor + text.length),
    );
    widget.onChanged();
  }

  void _backspace() {
    _haptic();
    final cursor = caretOffset(widget.controller);
    final deleteFrom = cursor > 0 ? cursor - 1 : 0;
    widget.controller.value = TextEditingValue(
      text: widget.controller.text.replaceRange(deleteFrom, cursor, ''),
      selection: TextSelection.collapsed(offset: deleteFrom),
    );
    widget.onChanged();
  }

  void _smartDot() {
    final text = widget.controller.text;
    final lastOperatorIndex = text.lastIndexOf(_operatorChar);
    final lastDotIndex = text.lastIndexOf('.');
    if (!_justEvaluated && lastDotIndex > lastOperatorIndex) return;
    insertText('.');
  }

  void _clear() {
    setTextKeepingCaret(widget.controller, '');
    widget.onChanged();
    widget.onClear?.call();
    _haptic();
  }

  void _equals() {
    widget.onPressed?.call();
    _haptic();
  }

  void _toggleDeg() {
    widget.onDegToggle?.call();
    _haptic();
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final (:buttonShape, :buttonElevation) = ref.watch(
      prefrencesProvider.select(
        (s) => (buttonShape: s.buttonShape, buttonElevation: s.buttonElevation),
      ),
    );
    final scientific = widget.isCalculator && widget.showScientific;
    final numeral = widget.isCalculator && !scientific
        ? Numerals.key
        : Numerals.keyCompact;
    final opGlyph = Numerals.key.copyWith(fontWeight: FontWeight.w300);
    final bigOpGlyph = opGlyph.copyWith(fontSize: 36);
    final stripLabel = Numerals.keyCompact.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    final shadows = buttonElevation == ButtonElevation.raised
        ? [
            BoxShadow(
              color: p.keyShadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ]
        : const <BoxShadow>[];

    Widget cell(
      String label,
      Widget content,
      VoidCallback onTap, {
      Color? color,
      Color? pressColor,
      ButtonShape? shape,
    }) {
      return PressMorph(
        label: label,
        onTap: onTap,
        color: color ?? p.key,
        pressColor: pressColor ?? p.keyPress,
        shape: shape ?? buttonShape,
        shadows: shadows,
        child: Center(child: content),
      );
    }

    Widget digit(String d) => cell(
      d,
      Text(d, style: numeral.copyWith(color: p.label)),
      () => insertText(d),
    );

    Widget symbol(String label, String spoken, VoidCallback onTap) => cell(
      spoken,
      Text(label, style: numeral.copyWith(color: p.label)),
      onTap,
      color: p.keyFn,
    );

    Widget op(String glyph, String spoken, String text, TextStyle style) =>
        cell(
          spoken,
          Text(glyph, style: style.copyWith(color: p.accent)),
          () => insertText(text),
          color: p.keyFn,
        );

    Widget ac() => cell(
      'Clear',
      Text(
        'AC',
        // Letters read larger than digits at the same size (mockup: 24 of 32).
        style: numeral.copyWith(
          color: p.danger,
          fontWeight: FontWeight.w500,
          fontSize: numeral.fontSize! * 0.75,
        ),
      ),
      _clear,
      color: p.keyFn,
    );

    Widget backspace() => cell(
      'Delete',
      Icon(AppIcons.backspace, size: 26, color: p.label),
      _backspace,
      color: p.keyFn,
    );

    Widget equals() => cell(
      'Equals',
      Text('=', style: numeral.copyWith(color: p.onAccent)),
      _equals,
      color: p.accent,
      pressColor: p.accentPress,
    );

    Widget fn(String label, String spoken, String text) => cell(
      spoken,
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(label, style: stripLabel.copyWith(color: p.label)),
      ),
      () => insertText(text),
      color: p.fill,
      shape: ButtonShape.round,
    );

    Widget degKey() => cell(
      widget.degMode ? 'Degrees' : 'Radians',
      FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          widget.degMode ? 'DEG' : 'RAD',
          style: stripLabel.copyWith(color: p.accent),
        ),
      ),
      _toggleDeg,
      color: p.accentSoft,
      shape: ButtonShape.round,
    );

    final dot = widget.isCalculator ? _smartDot : () => insertText('.');
    final keypad = [
      [
        ac(),
        symbol('( )', 'Parentheses', () => insertText('(')),
        scientific
            ? backspace()
            : symbol('%', 'Percent', () => insertText('%')),
        op('÷', 'Divide', '/', bigOpGlyph),
      ],
      [
        digit('7'),
        digit('8'),
        digit('9'),
        op('×', 'Multiply', 'x', bigOpGlyph),
      ],
      [digit('4'), digit('5'), digit('6'), op('−', 'Minus', '-', opGlyph)],
      [digit('1'), digit('2'), digit('3'), op('+', 'Plus', '+', opGlyph)],
      [
        symbol('±', 'Plus or minus', () => insertText('±')),
        digit('0'),
        cell('Point', Text('.', style: numeral.copyWith(color: p.label)), dot),
        widget.isCalculator ? equals() : backspace(),
      ],
    ];

    final strip = [
      [
        fn('sin', 'sine', 'sin('),
        fn('cos', 'cosine', 'cos('),
        fn('tan', 'tangent', 'tan('),
        fn('ln', 'natural log', 'ln('),
        fn('log', 'log', 'log('),
      ],
      [
        fn('sin⁻¹', 'arcsine', 'sin⁻¹('),
        fn('cos⁻¹', 'arccosine', 'cos⁻¹('),
        fn('tan⁻¹', 'arctangent', 'tan⁻¹('),
        fn('√', 'Square root', '√'),
        fn('x²', 'Squared', '²'),
      ],
      [
        fn('xʸ', 'Power', '^'),
        fn('π', 'Pi', 'π'),
        fn('e', "Euler's number", 'e'),
        fn('%', 'Percent', '%'),
        degKey(),
      ],
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          _sidePadding,
          0,
          _sidePadding,
          _bottomPadding,
        ),
        child: LayoutBuilder(
          builder: (context, box) {
            final height = box.maxHeight;
            final wide = box.maxWidth > height;
            // Caps key size so tablets get a centred pad, not huge keys.
            final cap =
                _maxKeyWidth * (scientific && wide ? 9 : 4) +
                _basicGap * (scientific && wide ? 8 : 3);
            final width = math.min(box.maxWidth, cap);
            final Widget pad;
            if (scientific && wide) {
              final keyHeight = math.max(
                0.0,
                math.min(_compactKeyHeight, (height - 4 * _compactGap) / 5),
              );
              pad = Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _rows(strip, keyHeight, _compactGap),
                  ),
                  const SizedBox(width: _bandGap),
                  Expanded(
                    flex: 4,
                    child: _rows(keypad, keyHeight, _compactGap),
                  ),
                ],
              );
            } else if (scientific) {
              final stripHeight = 3 * _stripKeyHeight + 2 * _stripGap;
              final keyHeight = math.max(
                0.0,
                math.min(
                  _compactKeyHeight,
                  (height - stripHeight - _bandGap - 4 * _compactGap) / 5,
                ),
              );
              pad = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _rows(strip, _stripKeyHeight, _stripGap),
                  SizedBox(height: _bandGap),
                  _rows(keypad, keyHeight, _compactGap),
                ],
              );
            } else if (widget.isCalculator) {
              final cellWidth = (width - 3 * _basicGap) / 4;
              final keyHeight = math.max(
                0.0,
                math.min(cellWidth, (height - 4 * _basicGap) / 5),
              );
              pad = _rows(keypad, keyHeight, _basicGap);
            } else {
              final keyHeight = math.max(
                0.0,
                math.min(_compactKeyHeight, (height - 4 * _compactGap) / 5),
              );
              pad = _rows(keypad, keyHeight, _compactGap);
            }
            // Natural height, not the full box: the calculator display takes the rest.
            return Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 1,
              child: RepaintBoundary(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: cap),
                  child: pad,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _rows(List<List<Widget>> rows, double keyHeight, double gap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var r = 0; r < rows.length; r++) ...[
          if (r > 0) SizedBox(height: gap),
          SizedBox(
            height: keyHeight,
            child: Row(
              children: [
                for (var c = 0; c < rows[r].length; c++) ...[
                  if (c > 0) SizedBox(width: gap),
                  Expanded(child: rows[r][c]),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
