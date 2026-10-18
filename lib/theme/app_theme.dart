import 'package:flutter/material.dart';

import '../provider/preferences_provider.dart';
import 'app_shapes.dart';
import 'palette.dart';
import 'tokens.dart';

final Map<(Color, Brightness, ButtonShape), ThemeData> _themes = {};

/// Builds (once per seed, brightness and key shape) the app theme. Screens read colors from
/// `Palette.of(context)` and shapes from `AppShapes.of(context)`; the [ColorScheme] follows for stock widgets.
ThemeData buildAppTheme(
  Color seed,
  Brightness brightness, [
  ButtonShape shape = ButtonShape.round,
]) => _themes.putIfAbsent((
  seed,
  brightness,
  shape,
), () => _build(seed, brightness, shape));

ThemeData _build(Color seed, Brightness brightness, ButtonShape shape) {
  final shapes = AppShapes(shape);
  final p = brightness == Brightness.light
      ? Palette.light(seed)
      : Palette.dark(seed);
  final scheme =
      ColorScheme.fromSeed(
        seedColor: seed,
        brightness: brightness,
        dynamicSchemeVariant: DynamicSchemeVariant.neutral,
      ).copyWith(
        primary: p.accent,
        onPrimary: p.onAccent,
        surface: p.bg,
        onSurface: p.label,
        onSurfaceVariant: p.label2,
        outlineVariant: p.separator,
        error: p.danger,
      );

  final base = ThemeData(colorScheme: scheme, fontFamily: Numerals.family);
  final text = base.textTheme.apply(bodyColor: p.label, displayColor: p.label);

  return base.copyWith(
    extensions: [p, shapes],
    textTheme: text,
    scaffoldBackgroundColor: p.bg,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    dividerTheme: DividerThemeData(
      color: p.separator,
      thickness: 0.5,
      space: 0.5,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      showDragHandle: false,
      shape: shapes.border(Radii.sheet),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: p.cell,
      surfaceTintColor: Colors.transparent,
      shape: shapes.border(Radii.xxxl),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: p.label,
      contentTextStyle: text.bodyMedium?.copyWith(color: p.bg),
      shape: shapes.border(Radii.md),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: p.accent,
      selectionColor: p.accentSoft,
      selectionHandleColor: p.accent,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: p.label),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: p.cell,
      surfaceTintColor: Colors.transparent,
      shape: shapes.border(Radii.lg),
    ),
  );
}
