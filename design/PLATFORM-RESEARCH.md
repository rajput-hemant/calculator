# Platform styles in Flutter - support check (18 Oct 2026)

Local toolchain: Flutter 3.47.7 stable. Beta is 3.50.0-0.1.pre.

## Android - Material 3 Expressive

**Status: partial, official work just started.**

- The Flutter SDK's `material` library has no M3 Expressive. The umbrella issue
  [flutter/flutter#168813](https://github.com/flutter/flutter/issues/168813) is open. Its July 2025
  update said new work would happen in standalone packages after the decoupling.
- Material is now decoupled into [`material_ui`](https://pub.dev/packages/material_ui) (1.7.0, 14 Oct 2026).
  Its first Expressive pieces have landed: the M3E `IconButton` and a migration skill were merged
  (flutter/packages #12832, #12818). The M3E `ElevatedButton` (#13084) is still open. Button groups,
  shape morphing, expressive sliders, flexible app bars and MaterialShapes are not shipped.
- Community packages cover the gap: [`m3e_core`](https://pub.dev/packages/m3e_core) (1.1.4: material shapes,
  button groups, floating toolbars, loading indicator) and
  [`material_expressive`](https://pub.dev/packages/material_expressive) (0.8.0: tokens, motion, shapes).

**Decision for the mockups:** design to M3 Expressive and build it on stock M3 `ThemeData` plus our own
widgets. That means:
- Connected button group: a `Row` of `FilledButton`s with per-side `BorderRadius`, animated on selection.
- Shape morph on key press: `AnimatedContainer` / `ShapeBorder.lerp` driven by a spring.
- Thick slider with a bar handle: `SliderThemeData` with custom track and thumb shapes.
- Category icon shapes: per-corner `BorderRadius`, or `m3e_core` MaterialShapes if we accept the dependency.

Move pieces over to `material_ui` as they ship. All of this already sits inside the app's
`ColorScheme.fromSeed` pipeline, so the user accent setting keeps working.

## iOS - Liquid Glass (iOS 26 / 27)

**Status: not in the SDK. Official package PRs opened yesterday.**

- [flutter/flutter#170310](https://github.com/flutter/flutter/issues/170310) is open: the SDK Cupertino
  widgets have no Liquid Glass. Official work has moved to [`cupertino_ui`](https://pub.dev/packages/cupertino_ui)
  (1.1.3). The Liquid Glass renderer and widgets PRs (flutter/packages #13162, #13163) were opened on
  17 Oct 2026 and are not merged. Nothing iOS 27-specific exists yet.
- Third-party options:
  - [`adaptive_platform_ui`](https://pub.dev/packages/adaptive_platform_ui) (1.0.2) and
    [`cupertino_native_better`](https://pub.dev/packages/cupertino_native_better) (1.6.0): real UIKit glass
    controls through platform views. These look exact, but each control is a platform view. That costs
    performance, and they fit chrome, not a 20-key keypad.
  - [`liquid_glass_renderer`](https://pub.dev/packages/liquid_glass_renderer) (0.2.0-dev): a shader-based
    lens effect. Pre-release, Impeller only.

**Decision for the mockups:** fall back to the latest supported style, Cupertino widgets in the
iOS 18 lineage. Approximate glass in pure Flutter: `ClipRRect` + `BackdropFilter(ImageFilter.blur(24),
plus a saturation ColorFilter)` + a tinted fill + a 1 px rim gradient + an outer shadow. Glass is used
only for floating chrome: top controls, the converter deck, sheets and the bottom search. Keys stay
opaque and custom-drawn. Lensing and refraction are left out. Swap `.glass` for `cupertino_ui`'s
widgets when #13162/#13163 ship.

## Type on each platform

- Android: Inter for chrome and numerals, bundled as a font asset (no runtime font download).
- iOS: SF Pro for chrome, which is Flutter's default on iOS. The direction's font is used for numerals
  and keys only, so the brand stays recognisable across platforms.
- Icons: Material Symbols on Android. On iOS, CupertinoIcons (`cupertino_icons` is already a
  dependency). The HTML mocks iOS icons with Material Symbols Rounded.
