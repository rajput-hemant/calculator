import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/glyphs.dart';

/// The calculator display: earlier equations stacked on top, then the
/// right-aligned expression with a caret and the result below it. In
/// scientific mode [angleUnit] shows a DEG/RAD capsule at the top left.
class CalcDisplay extends StatelessWidget {
  final TextEditingController controller;
  final String result;

  /// Evaluated equations, oldest first.
  final List<String> tape;

  /// Index into [tape] being edited in place; it shows the caret.
  final int? editing;

  /// A stacked equation was tapped, by index into [tape].
  final ValueChanged<int>? onTapeTap;

  /// The expression holds a result from `=`; show it as the result.
  final bool evaluated;
  final String? angleUnit;

  const CalcDisplay({
    super.key,
    required this.controller,
    required this.result,
    this.tape = const [],
    this.editing,
    this.onTapeTap,
    this.evaluated = false,
    this.angleUnit,
  });

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final scientific = angleUnit != null;
    final shown = evaluated ? controller.text : result;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (scientific)
            Align(
              alignment: Alignment.centerLeft,
              child: _AngleCapsule(
                label: angleUnit!,
                color: p.fill,
                textColor: p.label2,
              ),
            ),
          Expanded(
            child: _TapeRoller(
              lines: [
                for (final (i, line) in tape.indexed)
                  displayGlyphs(i == editing ? controller.text : line),
                if (editing == null && !evaluated)
                  displayGlyphs(controller.text),
              ],
              caret: editing ?? (evaluated ? null : tape.length),
              focus: editing ?? (evaluated ? tape.length - 1 : tape.length),
              onTap: (i) {
                if (i < tape.length) onTapeTap?.call(i);
              },
            ),
          ),
          AnimatedSwitcher(
            duration: Motion.quick,
            switchInCurve: Motion.enter,
            switchOutCurve: Motion.exit,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.12),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: FittedBox(
              key: ValueKey<String>(shown),
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                displayGlyphs(shown),
                maxLines: 1,
                style: (scientific ? Numerals.displayCompact : Numerals.display)
                    .copyWith(color: p.label),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AngleCapsule extends StatelessWidget {
  const _AngleCapsule({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
        color: color,
        shape: AppShapes.of(context).border(28 / 2),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          label,
          style: AppText.footnote.copyWith(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

/// Equations on a 3D drum, oldest first. The [focus] line sits at the front;
/// the others roll away over the top and can be scrolled into view.
class _TapeRoller extends StatefulWidget {
  const _TapeRoller({
    required this.lines,
    required this.focus,
    this.caret,
    this.onTap,
  });

  final List<String> lines;
  final int focus;

  /// The line being typed into, if any.
  final int? caret;
  final ValueChanged<int>? onTap;

  @override
  State<_TapeRoller> createState() => _TapeRollerState();
}

class _TapeRollerState extends State<_TapeRoller> {
  static const double _itemExtent = 40;

  late final FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: math.max(0, widget.focus));

  @override
  void didUpdateWidget(_TapeRoller oldWidget) {
    super.didUpdateWidget(oldWidget);
    final lines = widget.lines;
    final focus = widget.focus;
    // A new line, a new focus or typing brings the focused line to the front.
    final changed =
        focus != oldWidget.focus ||
        lines.length != oldWidget.lines.length ||
        focus >= oldWidget.lines.length ||
        lines[focus] != oldWidget.lines[focus];
    if (changed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_controller.hasClients) return;
        _controller.animateToItem(
          focus,
          duration: Motion.gentle,
          curve: Motion.enter,
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The wheel centers its selected item and recedes toward its own middle.
    // Doubling it and clipping the lower and right halves puts the front item
    // next to the result and makes lines recede straight back along the right.
    return LayoutBuilder(
      builder: (context, box) => ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: box.maxWidth * 2,
          maxWidth: box.maxWidth * 2,
          minHeight: 0,
          maxHeight: math.max(0, box.maxHeight * 2 - _itemExtent),
          child: _wheel(Palette.of(context), box.maxWidth),
        ),
      ),
    );
  }

  Widget _wheel(Palette p, double width) {
    final style = Numerals.expression.copyWith(color: p.label2);
    return ListWheelScrollView.useDelegate(
      controller: _controller,
      itemExtent: _itemExtent,
      diameterRatio: 1.4,
      perspective: 0.006,
      overAndUnderCenterOpacity: 0.5,
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.lines.length,
        builder: (context, i) => Padding(
          padding: EdgeInsets.only(right: width),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => widget.onTap?.call(i),
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.lines[i], maxLines: 1, style: style),
                    if (i == widget.caret)
                      Container(
                        width: 2,
                        height: 28,
                        margin: const EdgeInsets.only(left: 2),
                        color: p.accent,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
