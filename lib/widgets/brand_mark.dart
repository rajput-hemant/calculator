import 'package:flutter/material.dart';

import '../theme/palette.dart';

/// The app mark drawn from shapes: two `label` tiles with minus and plus and
/// one tall `accent` tile with an equals sign, on a `fill` square.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final tile = size * 0.33;
    final gap = size * 0.06;
    final tileRadius = BorderRadius.circular(size * 0.06);
    final bar = tile * 0.5;
    final thick = tile * 0.14;

    Widget glyph(Color color, List<Size> bars) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (i, b) in bars.indexed) ...[
            if (i > 0) SizedBox(height: thick * 1.6),
            Container(
              width: b.width,
              height: b.height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(thick / 2),
              ),
            ),
          ],
        ],
      ),
    );

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.14),
      decoration: BoxDecoration(
        color: p.fill,
        borderRadius: BorderRadius.circular(size * 0.26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Tile(
                size: tile,
                radius: tileRadius,
                color: p.label,
                child: glyph(p.bg, [Size(bar, thick)]),
              ),
              SizedBox(height: gap),
              _Tile(
                size: tile,
                radius: tileRadius,
                color: p.label,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: bar,
                        height: thick,
                        decoration: BoxDecoration(
                          color: p.bg,
                          borderRadius: BorderRadius.circular(thick / 2),
                        ),
                      ),
                      Container(
                        width: thick,
                        height: bar,
                        decoration: BoxDecoration(
                          color: p.bg,
                          borderRadius: BorderRadius.circular(thick / 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: gap),
          _Tile(
            size: tile,
            height: tile * 2 + gap,
            radius: tileRadius,
            color: p.accent,
            child: glyph(p.onAccent, [Size(bar, thick), Size(bar, thick)]),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.size,
    required this.radius,
    required this.color,
    required this.child,
    this.height,
  });

  final double size;
  final double? height;
  final BorderRadius radius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: height ?? size,
      decoration: BoxDecoration(color: color, borderRadius: radius),
      child: child,
    );
  }
}
