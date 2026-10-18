import 'dart:math' as math;

import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// WCAG 2.1 relative luminance and contrast ratio, used to prove the icon
// badge backdrop is actually visible against the icon artwork.
double _luminance(Color c) {
  double channel(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();

  return 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  // The dark tiles sampled from assets/images/app_icon.png.
  const mark = Color(0xFF2D3237);

  // The badge backdrops are scheme tokens picked in _AppIconBadge
  // (lib/screens/settings_screen.dart and lib/screens/about_screen.dart);
  // keep both files in sync with this test.
  test('light badge backdrop contrasts the icon mark', () {
    final ratio = _contrast(lightColorScheme.surfaceContainerHighest, mark);
    debugPrint(
      'light badge backdrop vs #2D3237: ${ratio.toStringAsFixed(2)}:1',
    );

    expect(ratio, greaterThanOrEqualTo(4.5));
  });

  test('dark badge backdrop contrasts the icon mark', () {
    final ratio = _contrast(darkColorScheme.onSurfaceVariant, mark);
    debugPrint('dark badge backdrop vs #2D3237: ${ratio.toStringAsFixed(2)}:1');

    expect(ratio, greaterThanOrEqualTo(4.5));
  });
}
