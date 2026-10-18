import 'package:flutter/material.dart';

import 'tokens.dart';

/// The dark scheme, derived from the brand seed. See `light.dart` for why the
/// variant is `vibrant` and not `expressive`.
final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: Tokens.seed,
  brightness: Brightness.dark,
  dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
);
