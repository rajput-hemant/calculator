# Calculator app icon

Evolved from the existing brand (minus + plus left, equals right) with modern craft and the real Material 3 theme.

## Master source

`app-icon-master.svg` - light, dark and tinted groups. Open in a browser or editor; export at any size.

## Variants and hexes

| Variant | Tile fill | Tile depth | Glyph | Background / framing |
|---|---|---|---|---|
| Light (default) | `#005EB2` (primary) / `#2D3237` (neutral) | `#36393F` inset at 0.35 opacity | `#FFFFFF` | `#F0F3F7` framing |
| Dark | `#A7C8FF` (primary) / `#1C2125` (neutral) | `#24282D` inset at 0.35 opacity | `#0A0E14` | `#0F141C` framing |
| Tinted | `#A0A2A8` grayscale base at 0.85 opacity | `#808080` inset at 0.35 opacity | `#FFFFFF` at 0.85 opacity | `#B8BCC2` at 0.5 opacity |

Glyph contrast stays at or above 4.5:1 in all variants.

## Regenerate

From the SVG master:

```bash
# PNG at exact size (example 512)
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless=new --disable-gpu --screenshot=output.png --window-size=512,512 --hide-scrollbars file://$(pwd)/app-icon-master.svg
```

Or with `sips` (macOS):

```bash
sips -z 512 512 app-icon-master.svg output-512.png
```

Android mipmaps and adaptive layers use the same master: scale to 48/72/96/144/192 for legacy mipmaps, 432 for adaptive foreground.

## Wired files

- `assets/images/app_icon.png` - refreshed About screen image
- `android/app/src/main/res/mipmap-*/ic_launcher.png` - all densities
- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` - adaptive icon
- `android/app/src/main/res/values/ic_launcher_background.xml` - background colour
- `android/app/src/main/res/drawable/ic_launcher_foreground.png` - adaptive foreground
- `android/app/src/main/res/drawable/ic_launcher_monochrome.png` - Android 13 monochrome
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/*.png` - light set (1024 marketing + all scales)
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json` - valid; light only (dark/tinted PNGs present but schema not confirmed)

## What was skipped / not verified

- The exact iOS 18 `Contents.json` appearance keys schema for dark and tinted was not confirmed; those variants are present as PNG files but not wired in Contents.json. Confirm the schema before adding them.
- No new dependencies added; no version bump, no pubspec changes.
