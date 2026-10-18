import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../provider/preferences_provider.dart';
import '../theme/tokens.dart';

/// A key surface that darkens and morphs toward a rounded square while
/// pressed, then springs back on release.
class PressMorph extends StatefulWidget {
  const PressMorph({
    super.key,
    required this.label,
    required this.child,
    required this.onTap,
    required this.color,
    required this.pressColor,
    required this.shape,
    this.shadows = const [],
  });

  /// Spoken name for screen readers; the child's text is excluded.
  final String label;
  final Widget child;
  final VoidCallback onTap;
  final Color color;
  final Color pressColor;
  final ButtonShape shape;
  final List<BoxShadow> shadows;

  @override
  State<PressMorph> createState() => _PressMorphState();
}

class _PressMorphState extends State<PressMorph>
    with SingleTickerProviderStateMixin {
  // Pressed key morphs to this fraction of its shorter side.
  static const double _pressedRadiusFactor = 0.28;

  static const double _roundedRadius = 19;

  // A superellipse corner reads as the same size at about 1.5x the radius of a
  // circular one, matching iOS app icons.
  static const double _squircleScale = 1.5;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _press() {
    _controller.animateTo(1, duration: Motion.quick, curve: Motion.enter);
  }

  void _release() {
    _controller.animateWith(
      SpringSimulation(Motion.soft, _controller.value, 0, 0),
    );
  }

  // Both ends of the press lerp must share a border type, so the squircle
  // stays a superellipse while pressed.
  static ShapeBorder _border(ButtonShape shape, double radius) {
    final corners = BorderRadius.circular(radius);
    return switch (shape) {
      ButtonShape.squircle => RoundedSuperellipseBorder(borderRadius: corners),
      _ => RoundedRectangleBorder(borderRadius: corners),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      onTap: widget.onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _press(),
        onTapUp: (_) => _release(),
        onTapCancel: _release,
        onTap: widget.onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final side = constraints.biggest.shortestSide;
            final half = side / 2;
            final restRadius = switch (widget.shape) {
              ButtonShape.round => half,
              ButtonShape.rounded => _roundedRadius,
              ButtonShape.squircle => _roundedRadius * _squircleScale,
            };
            final rest = _border(widget.shape, math.min(restRadius, half));
            final pressed = _border(widget.shape, side * _pressedRadiusFactor);
            return AnimatedBuilder(
              animation: _controller,
              child: widget.child,
              builder: (context, child) {
                final t = _controller.value;
                return DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Color.lerp(widget.color, widget.pressColor, t),
                    shape: ShapeBorder.lerp(rest, pressed, t)!,
                    shadows: widget.shadows,
                  ),
                  child: child,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
