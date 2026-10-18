import 'package:flutter/material.dart';

import 'tokens.dart';

/// The light scheme, derived from the brand seed.
///
/// `vibrant` raises the chroma without moving the hue. `expressive` is
/// deliberately not used here: it rotates the seed hue by 240 degrees, which
/// turns this blue into a green.
final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: Tokens.seed,
  brightness: Brightness.light,
  dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
);
