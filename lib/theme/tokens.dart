import 'package:flutter/material.dart';

/// Single source of truth for the values the design system reuses.
/// Check here before hardcoding a radius, gap or duration in a widget.
abstract final class Tokens {
  /// Brand seed. Every colour in the app is derived from this, never picked
  /// by hand. Change it here and the whole app follows.
  static const int seedValue = 0xFF207CDF;
  static const Color seed = Color(seedValue);

  /// Touch targets are never smaller than this, however small the drawing is.
  static const double minTapTarget = 48;

  /// Floating top bar height, below the status bar.
  static const double topBarHeight = 64;

  /// Top bar buttons and capsule controls; the Android minimum tap target.
  static const double control = 48;

  /// Space content leaves for the floating top bar.
  static double topBarInset(BuildContext context) =>
      MediaQuery.paddingOf(context).top + topBarHeight;
}

/// Corner radii, on the Material 3 shape scale.
abstract final class Radii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xxxl = 28;

  /// Capsule controls (half of [Tokens.control]).
  static const double control = 24;

  /// Inset groups and converter cards.
  static const double card = 26;

  /// Floating bottom sheets.
  static const double sheet = 40;
}

/// Gaps between things, in logical pixels.
abstract final class Gaps {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double huge = 32;
}

/// Durations, curves and springs.
///
/// Durations and curves are for anything that animates on its own. Springs are
/// for anything the finger is still touching, so it settles instead of
/// snapping when released.
abstract final class Motion {
  static const Duration quick = Duration(milliseconds: 120);
  static const Duration standard = Duration(milliseconds: 220);
  static const Duration gentle = Duration(milliseconds: 380);

  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;

  /// Slows into place with almost no overshoot. The default for most motion.
  static final SpringDescription soft = SpringDescription.withDampingRatio(
    mass: 1,
    stiffness: 380,
    ratio: 0.9,
  );
}

/// Text roles for UI chrome (font comes from the theme). Colors are applied
/// where used.
abstract final class AppText {
  static const TextStyle largeTitle = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle title = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle body = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    letterSpacing: -0.4,
  );
  static const TextStyle callout = TextStyle(fontSize: 15, height: 20 / 15);
  static const TextStyle footnote = TextStyle(fontSize: 13, height: 18 / 13);
}

/// Numeral styles: Inter with tabular figures and the flat-top 1 (cv11), so
/// digits never jitter while typing. Used on both platforms; colors come from
/// the widget using them.
abstract final class Numerals {
  static const String family = 'Inter';
  static const List<FontFeature> features = [
    FontFeature.tabularFigures(),
    FontFeature('cv11'),
  ];

  static const TextStyle display = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 76,
    fontWeight: FontWeight.w300,
    height: 1,
    letterSpacing: -3,
  );
  static const TextStyle displayCompact = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 60,
    fontWeight: FontWeight.w300,
    height: 1,
    letterSpacing: -2.4,
  );
  static const TextStyle expression = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.3,
  );
  static const TextStyle key = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 32,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle keyCompact = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 26,
    fontWeight: FontWeight.w400,
  );

  /// Converter values.
  static const TextStyle value = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 44,
    fontWeight: FontWeight.w300,
    height: 1.1,
    letterSpacing: -1.3,
  );

  /// History results.
  static const TextStyle result = TextStyle(
    fontFamily: family,
    fontFeatures: features,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );
}
