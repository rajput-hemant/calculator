import 'package:flutter/material.dart';

import '../provider/preferences_provider.dart';

/// The key shape setting applied to every rounded surface. Read it with
/// `AppShapes.of(context).border(radius)`, where [radius] is the surface's
/// design radius (for a 48 dp control, a capsule).
@immutable
class AppShapes extends ThemeExtension<AppShapes> {
  const AppShapes(this.shape);

  final ButtonShape shape;

  static AppShapes of(BuildContext context) =>
      Theme.of(context).extension<AppShapes>() ??
      const AppShapes(ButtonShape.round);

  OutlinedBorder border(double radius) =>
      corners(BorderRadius.circular(radius));

  /// For surfaces whose corners differ, such as the first and last rows of a list.
  OutlinedBorder corners(BorderRadius radius) => switch (shape) {
    ButtonShape.round => RoundedRectangleBorder(borderRadius: radius),
    ButtonShape.rounded => RoundedRectangleBorder(borderRadius: radius * 0.45),
    ButtonShape.squircle => RoundedSuperellipseBorder(
      borderRadius: radius * 0.7,
    ),
  };

  @override
  AppShapes copyWith({ButtonShape? shape}) => AppShapes(shape ?? this.shape);

  @override
  AppShapes lerp(covariant ThemeExtension<AppShapes>? other, double t) =>
      other is AppShapes && t >= 0.5 ? other : this;
}
