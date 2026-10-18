import 'package:flutter/material.dart';

/// The Paper palette: neutral surfaces plus one accent derived from the
/// user's accent seed. Read it with `Palette.of(context)`.
///
/// Values mirror `design/mockups/direction-a/tokens.json` (iOS semantic
/// colors), used on both platforms so Android matches iOS.
@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.bg,
    required this.grouped,
    required this.cell,
    required this.card,
    required this.thumb,
    required this.fill,
    required this.key,
    required this.keyFn,
    required this.keyPress,
    required this.keyShadow,
    required this.label,
    required this.label2,
    required this.label3,
    required this.separator,
    required this.accent,
    required this.onAccent,
    required this.accentSoft,
    required this.accentPress,
    required this.danger,
    required this.glass,
    required this.glassRim,
    required this.glassShadow,
    required this.scrim,
  });

  /// Calculator and converter background.
  final Color bg;

  /// Background behind inset grouped lists.
  final Color grouped;

  /// Inset group, card and sheet surface.
  final Color cell;

  /// Cards that sit directly on [bg] (converter From/To).
  final Color card;

  /// Selected segment of a segmented control.
  final Color thumb;

  /// Neutral fill for search fields, chips and unselected controls.
  final Color fill;

  final Color key;
  final Color keyFn;
  final Color keyPress;

  /// Raised keys.
  final Color keyShadow;

  final Color label;
  final Color label2;
  final Color label3;
  final Color separator;

  final Color accent;
  final Color onAccent;
  final Color accentSoft;

  /// Equals key while pressed.
  final Color accentPress;

  final Color danger;

  final Color glass;
  final Color glassRim;
  final Color glassShadow;
  final Color scrim;

  static Palette of(BuildContext context) =>
      Theme.of(context).extension<Palette>()!;

  factory Palette.light(Color seed) {
    final accent = _accent(seed, Brightness.light);
    return Palette(
      bg: const Color(0xFFFFFFFF),
      grouped: const Color(0xFFF2F2F7),
      cell: const Color(0xFFFFFFFF),
      card: const Color(0xFFF2F2F7),
      thumb: const Color(0xFFFFFFFF),
      fill: const Color(0x1F787880),
      key: const Color(0xFFF2F2F7),
      keyFn: const Color(0xFFE5E5EA),
      keyPress: const Color(0xFFD1D1D6),
      keyShadow: const Color(0x14000000),
      label: const Color(0xFF000000),
      label2: const Color(0x993C3C43),
      label3: const Color(0x4D3C3C43),
      separator: const Color(0x2E3C3C43),
      accent: accent,
      onAccent: _on(accent),
      accentSoft: accent.withValues(alpha: 0.12),
      accentPress: Color.lerp(accent, const Color(0xFF000000), 0.2)!,
      danger: const Color(0xFFE5402C),
      glass: const Color(0x9EFFFFFF),
      glassRim: const Color(0xD9FFFFFF),
      glassShadow: const Color(0x14000000),
      scrim: const Color(0x33000000),
    );
  }

  factory Palette.dark(Color seed) {
    final accent = _accent(seed, Brightness.dark);
    return Palette(
      bg: const Color(0xFF000000),
      grouped: const Color(0xFF000000),
      cell: const Color(0xFF1C1C1E),
      card: const Color(0xFF1C1C1E),
      thumb: const Color(0xFF636366),
      fill: const Color(0x3D767680),
      key: const Color(0xFF1C1C1E),
      keyFn: const Color(0xFF2C2C2E),
      keyPress: const Color(0xFF3A3A3C),
      keyShadow: const Color(0x66000000),
      label: const Color(0xFFFFFFFF),
      label2: const Color(0x99EBEBF5),
      label3: const Color(0x4DEBEBF5),
      separator: const Color(0x8C545458),
      accent: accent,
      onAccent: _on(accent),
      accentSoft: accent.withValues(alpha: 0.18),
      accentPress: Color.lerp(accent, const Color(0xFFFFFFFF), 0.2)!,
      danger: const Color(0xFFFF6B57),
      glass: const Color(0x8C2C2C30),
      glassRim: const Color(0x29FFFFFF),
      glassShadow: const Color(0x00000000),
      scrim: const Color(0x73000000),
    );
  }

  // The seed is the light accent; dark mode lifts it so it reads on black.
  static Color _accent(Color seed, Brightness brightness) {
    final hsl = HSLColor.fromColor(seed);
    if (brightness == Brightness.light) {
      return hsl.withLightness(hsl.lightness.clamp(0.3, 0.5)).toColor();
    }
    return hsl.withLightness(0.68).toColor();
  }

  static Color _on(Color accent) =>
      ThemeData.estimateBrightnessForColor(accent) == Brightness.dark
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF0B0B0C);

  @override
  Palette copyWith({
    Color? bg,
    Color? grouped,
    Color? cell,
    Color? card,
    Color? thumb,
    Color? fill,
    Color? key,
    Color? keyFn,
    Color? keyPress,
    Color? keyShadow,
    Color? label,
    Color? label2,
    Color? label3,
    Color? separator,
    Color? accent,
    Color? onAccent,
    Color? accentSoft,
    Color? accentPress,
    Color? danger,
    Color? glass,
    Color? glassRim,
    Color? glassShadow,
    Color? scrim,
  }) => Palette(
    bg: bg ?? this.bg,
    grouped: grouped ?? this.grouped,
    cell: cell ?? this.cell,
    card: card ?? this.card,
    thumb: thumb ?? this.thumb,
    fill: fill ?? this.fill,
    key: key ?? this.key,
    keyFn: keyFn ?? this.keyFn,
    keyPress: keyPress ?? this.keyPress,
    keyShadow: keyShadow ?? this.keyShadow,
    label: label ?? this.label,
    label2: label2 ?? this.label2,
    label3: label3 ?? this.label3,
    separator: separator ?? this.separator,
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    accentSoft: accentSoft ?? this.accentSoft,
    accentPress: accentPress ?? this.accentPress,
    danger: danger ?? this.danger,
    glass: glass ?? this.glass,
    glassRim: glassRim ?? this.glassRim,
    glassShadow: glassShadow ?? this.glassShadow,
    scrim: scrim ?? this.scrim,
  );

  @override
  Palette lerp(Palette? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return Palette(
      bg: l(bg, other.bg),
      grouped: l(grouped, other.grouped),
      cell: l(cell, other.cell),
      card: l(card, other.card),
      thumb: l(thumb, other.thumb),
      fill: l(fill, other.fill),
      key: l(key, other.key),
      keyFn: l(keyFn, other.keyFn),
      keyPress: l(keyPress, other.keyPress),
      keyShadow: l(keyShadow, other.keyShadow),
      label: l(label, other.label),
      label2: l(label2, other.label2),
      label3: l(label3, other.label3),
      separator: l(separator, other.separator),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      accentSoft: l(accentSoft, other.accentSoft),
      accentPress: l(accentPress, other.accentPress),
      danger: l(danger, other.danger),
      glass: l(glass, other.glass),
      glassRim: l(glassRim, other.glassRim),
      glassShadow: l(glassShadow, other.glassShadow),
      scrim: l(scrim, other.scrim),
    );
  }
}
