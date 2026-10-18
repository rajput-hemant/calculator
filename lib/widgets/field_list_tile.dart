import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/unit.dart';
import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import 'currency_badge.dart';
import 'glass.dart';
import 'readable_width.dart';
import 'select_unit_sheet.dart';

/// One From/To card: a unit button and an editable value. Shared by the
/// length-style converter and the currency screen.
class FieldListTile extends StatefulWidget {
  const FieldListTile({
    super.key,
    required this.controller,
    required this.list,
    required this.title,
    this.isCurrency = false,
    this.isOutput = false,
    required this.isFieldSelected,
    required this.onFieldSelect,
    required this.onLabelSelect,
    required this.fieldIndex,
    required this.changeSelectedIndex,
  });

  final TextEditingController controller;
  final List<Unit> list;

  /// Sheet title, e.g. "Length unit".
  final String title;
  final bool isCurrency;
  final bool isOutput;
  final bool isFieldSelected;
  final VoidCallback onFieldSelect;
  final VoidCallback onLabelSelect;
  final int fieldIndex;
  final ValueChanged<int> changeSelectedIndex;

  @override
  State<FieldListTile> createState() => _FieldListTileState();
}

class _FieldListTileState extends State<FieldListTile> {
  final ScrollController _scrollController = ScrollController();
  String? _measuredText;
  double _measuredWidth = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollToCaret);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCaret());
  }

  @override
  void didUpdateWidget(covariant FieldListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_scrollToCaret);
      widget.controller.addListener(_scrollToCaret);
    }
    if (!oldWidget.isFieldSelected && widget.isFieldSelected) {
      _scrollToCaret();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollToCaret);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCaret() {
    if (!widget.isFieldSelected) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  /// Width of [text] at the value size. Cached by text, since the layout
  /// builder rebuilds on every caret move as well as every keystroke.
  double _textWidth(String text) {
    if (text != _measuredText) {
      final painter = TextPainter(
        text: TextSpan(text: text, style: Numerals.value),
        textDirection: TextDirection.ltr,
      )..layout();
      _measuredText = text;
      _measuredWidth = painter.width;
      painter.dispose();
    }
    return _measuredWidth;
  }

  Future<void> _pickUnit() async {
    widget.onLabelSelect();
    final selectedIndex = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: const BoxConstraints(maxWidth: ReadableWidth.maxWidth),
      barrierColor: Palette.of(context).scrim,
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        final keyboard = MediaQuery.viewInsetsOf(context).bottom;
        final bottom = math.max(keyboard, MediaQuery.paddingOf(context).bottom);
        final topSafe = MediaQuery.paddingOf(context).top;
        return Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 8 + bottom),
          child: Glass(
            shape: AppShapes.of(context).border(Radii.sheet),
            child: SizedBox(
              height: math.min(
                0.7 * size.height,
                size.height - keyboard - topSafe - 16,
              ),
              child: SelectUnitSheet(
                title: widget.title,
                list: widget.list,
                isCurrency: widget.isCurrency,
                selectedUnitIndex: widget.fieldIndex,
              ),
            ),
          ),
        );
      },
    );
    if (selectedIndex != null && mounted) {
      widget.changeSelectedIndex(selectedIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final isCurrency = widget.isCurrency;
    final unit = widget.list[widget.fieldIndex];
    final valueColor = widget.isOutput ? p.accent : p.label;
    final pill = AppShapes.of(context).border(Radii.control);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Gaps.lg, vertical: 4),
      padding: const EdgeInsets.fromLTRB(Gaps.lg, Gaps.md, Gaps.lg, Gaps.lg),
      decoration: ShapeDecoration(
        color: p.card,
        shape: AppShapes.of(context).border(Radii.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.isOutput ? 'To' : 'From',
            style: AppText.footnote.copyWith(color: p.label2),
          ),
          const SizedBox(height: Gaps.sm),
          LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                // The unit pill takes at most half the card so a long name
                // can't push the value off the edge.
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth / 2,
                  ),
                  child: Tooltip(
                    message: isCurrency ? 'Select currency' : 'Select unit',
                    child: Material(
                      color: p.fill,
                      shape: pill,
                      child: InkWell(
                        customBorder: pill,
                        onTap: _pickUnit,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Tokens.minTapTarget,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              isCurrency ? 4 : 14,
                              0,
                              10,
                              0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isCurrency)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: CurrencyBadge(code: unit.id),
                                  ),
                                Flexible(
                                  child: Text(
                                    unit.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppText.title.copyWith(
                                      color: p.label,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  unit.id,
                                  style: AppText.callout.copyWith(
                                    color: p.label2,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  AppIcons.expand,
                                  size: 16,
                                  color: p.label2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Gaps.md),
                Expanded(
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: widget.controller,
                    builder: (context, value, _) => LayoutBuilder(
                      builder: (context, constraints) {
                        final style = Numerals.value.copyWith(
                          color: valueColor,
                        );
                        // Shrink long values to fit the card; the field still
                        // scrolls to the caret below the floor.
                        final scale =
                            (constraints.maxWidth / _textWidth(value.text))
                                .clamp(0.5, 1.0);

                        return TextField(
                          controller: widget.controller,
                          scrollController: _scrollController,
                          autofocus: widget.isFieldSelected,
                          showCursor: widget.isFieldSelected,
                          readOnly: true,
                          keyboardType: TextInputType.none,
                          textAlign: TextAlign.end,
                          style: style.copyWith(
                            fontSize: Numerals.value.fontSize! * scale,
                          ),
                          decoration: const InputDecoration(
                            filled: false,
                            border: InputBorder.none,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onTap: () {
                            widget.onFieldSelect();
                            widget.controller.selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                    offset: widget.controller.text.length,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
