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

Export the SVG at any size, e.g. 512 with headless Chrome:

```bash
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless=new --disable-gpu --screenshot=output.png --window-size=512,512 --hide-scrollbars file://$(pwd)/app-icon-master.svg
```

## Wired files

- `assets/images/app_icon.png` - README image
- `android/app/src/main/res/mipmap-*/ic_launcher.png` - legacy launcher icons
- `android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml` - adaptive icon
- `android/app/src/main/res/drawable/ic_launcher_foreground.xml` and `ic_launcher_monochrome.xml` - vector layers
- `android/app/src/main/res/values/ic_launcher_adaptive_background.xml` - adaptive background colour
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/` - iOS icons
