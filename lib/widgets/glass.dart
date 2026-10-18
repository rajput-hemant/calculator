import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';

// Saturation 1.8, applied under the blur so colors behind the glass glow.
const List<double> _saturate = [
  1.6362, -0.5726, -0.0636, 0, 0, //
  -0.1638, 1.2274, -0.0636, 0, 0, //
  -0.1638, -0.5726, 1.7364, 0, 0, //
  0, 0, 0, 1, 0, //
];

/// Liquid Glass approximation: blur + saturation + tint + rim + shadow.
///
/// ponytail: no lensing or refraction (needs a shader); swap for a real
/// glass material if Flutter ships one.
class Glass extends StatelessWidget {
  const Glass({super.key, required this.child, this.shape, this.color});

  final Widget child;

  /// Defaults to the control shape of the key style.
  final OutlinedBorder? shape;

  /// Overrides the glass tint, for tinted (accent) glass.
  final Color? color;

  /// The faint lift glass surfaces cast, kept shallow so controls read flat
  /// as in the mockup. Reuse it for floating marks.
  static List<BoxShadow> shadow(Palette p) => [
    BoxShadow(color: p.glassShadow, blurRadius: 12, offset: const Offset(0, 2)),
  ];

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final border = shape ?? AppShapes.of(context).border(Radii.control);
    return DecoratedBox(
      decoration: ShapeDecoration(shape: border, shadows: shadow(p)),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: border),
        // Shares one backdrop read with every other glass surface on screen
        // (BackdropGroup in main.dart).
        child: BackdropFilter.grouped(
          filter: ui.ImageFilter.compose(
            outer: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            inner: const ColorFilter.matrix(_saturate),
          ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: color ?? p.glass,
              shape: border.copyWith(
                side: BorderSide(color: p.glassRim, width: 0.8),
              ),
            ),
            // Gives ink splashes a surface above the tint.
            child: Material(type: MaterialType.transparency, child: child),
          ),
        ),
      ),
    );
  }
}
