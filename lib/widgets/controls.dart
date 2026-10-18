import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';

/// Segmented control: capsule track with a sliding thumb. The track is 40 dp
/// tall; each segment's touch area is the full 48 dp row.
class PillSegmented<T> extends StatelessWidget {
  const PillSegmented({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  /// Value to label, in display order.
  final Map<T, String> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final keys = segments.keys;
    final index = keys.toList().indexOf(selected);
    assert(index >= 0, 'selected must be one of the segments');
    final n = keys.length;
    final shapes = AppShapes.of(context);
    return SizedBox(
      height: Tokens.minTapTarget,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.all(2),
            decoration: ShapeDecoration(
              color: p.fill,
              shape: shapes.border(20),
            ),
            child: AnimatedAlign(
              duration: Motion.standard,
              curve: Motion.enter,
              alignment: Alignment(n == 1 ? 0 : -1 + 2 * index / (n - 1), 0),
              child: FractionallySizedBox(
                widthFactor: 1 / n,
                heightFactor: 1,
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: p.thumb,
                    shape: shapes.border(18),
                    shadows: [
                      BoxShadow(
                        color: p.keyShadow,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (final key in keys)
                Expanded(
                  child: Semantics(
                    button: true,
                    selected: key == selected,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onChanged(key),
                      child: Center(
                        child: Text(
                          segments[key]!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: key == selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: p.label,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// iOS-style switch (the Paper design uses it on Android too).
class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) => CupertinoSwitch(
    value: value,
    onChanged: onChanged,
    activeTrackColor: Palette.of(context).accent,
  );
}

/// Grey capsule search field.
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: p.fill,
        shape: AppShapes.of(context).border(Radii.control),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: AppText.body.copyWith(color: p.label),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppText.body.copyWith(color: p.label2),
          prefixIcon: Icon(AppIcons.search, color: p.label2, size: 20),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
