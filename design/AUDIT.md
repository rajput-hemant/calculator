# UI audit - current build (0.2.5, master f58509b)

Captured on a Samsung SM-A346E (Android 16, 1080x2340), accent set to pink, system dark and light.
Screenshots: `design/audit/`. Built-in Samsung calculator for comparison: `design/audit/16-samsung.png`.

## Ranked issues

### P0 - reads as unfinished

1. **Display hierarchy is inverted and loud.** The expression is 56 px w700 in `primary`, the live result 42 px w600 in `secondary` (`calc_display.dart`). Two saturated colors and two heavy weights compete; after `=` the answer sits in the expression slot in accent pink. Every reference calculator shows the expression muted and the answer as the single dominant element, in a neutral color. The font is the default Roboto with proportional figures, so digits jitter while typing.
2. **No type system.** No `google_fonts`, no tabular figures, sizes picked per widget (29, 12.5, 11.5, 10.5, 14.5 px in converter/sheet widgets). About uses `fontFamily: 'PTSans'`, which is not bundled, so it silently falls back. Mixed `bold`/`w600`/`w700` titles across app bars.
3. **Settings looks like a debug panel.** The whole list sits inside a `secondaryContainer` slab (brown in dark, pink in light) with 4 px margins; a 104 px wide pill holds the app icon for no reason; every control is a stacked `ListTile` subtitle so rows have no left/right rhythm. Segmented buttons barely show the selected state. 17 accent swatches, several of which (yellow, lime) produce poor tonal schemes. Haptics is a lone switch under its label instead of a trailing control.
4. **Light theme keys are muddy.** `surfaceContainerHigh` from the vibrant variant gives mauve-grey keys with a 3D shadow on a pink-white page: low contrast between digit, function and operator keys, and the `AC` key is a saturated `error` block that outweighs `=`.

### P1 - inconsistent

5. **Two converter layouts.** Length conversion and Currency use different card shapes, label styles ("From" vs "FROM"), field heights and selector chips. The `To` card is a saturated primary slab with a black chip on it. Currency rate line truncates ("1 INR = 0.010...") and leaves a dead band above the keypad.
6. **Brand mark ignores the theme.** App bar and About icon are a hard-coded blue PNG; with any non-blue accent the brand clashes with every other color on screen.
7. **Unit picker rows use meaningless letter avatars** (c, d, f, i, k...) derived from the name; the selected row is a full-saturation slab plus a check plus colored text (three signals for one state).
8. **Glyphs are not typographic.** Minus is a hyphen `-`, power is `x^y`, the expression shows a letter `x` instead of `×`, results show `100.0` (trailing zero) in the converter.
9. **History rows** are plain: generic calculator icon in grey, `= 120.5` in primary, "Just now" at 11 px, no day grouping, full-bleed divider only between some rows.

### P2 - polish

10. **Spacing has no rhythm.** Keypad uses 6 px gap + 4 px per-key padding + 12 px container padding + 4 px grid inset (effectively 14 px gaps, 16 px sides); display uses 24 + 24 padding; converter cards 14/16/20. Values are not on the 4/8 scale in `tokens.dart`.
11. **Scientific mode** keeps the same weight and color for 28 keys; function keys (`sin`, `log`) look identical to digits but smaller, and `DEG/RAD` is disguised as a key instead of a mode indicator.
12. **App bar** mixes a raster icon, a 16 px title and four 24 px actions; `Σ` for "scientific" is not a recognized affordance (Samsung uses a dedicated icon, Google a chevron).
13. **About** is centered marketing copy with a raster GitHub logo button, two emoji, and "Made with ❤️ using Flutter" pinned to the bottom. No license page link.
14. **Elevation**: raised keys use a black 15% blur shadow that looks dirty in dark mode; cards have none; sheets have none. No consistent elevation model.
15. **Tap targets** are fine (keys about 80 px), but the swap button in the converter is 36 px and the history items' trailing results have no action affordance.

## What the built-in calculator does better

- One accent (the `=` key), neutral everything else.
- Thin, large display numerals; the expression is the live input, the result is a quiet preview.
- Circular keys with clear tiers: digits, operators (lighter), clear (red glyph only, no red fill).
- Minimal chrome: icons only, no title.

## Strengths to keep

- Material 3 `ColorScheme.fromSeed` pipeline and the user accent option.
- Square keys that fill the width; generous 80 px targets.
- Search on category and unit lists; drag handle on sheets.
- Tokens file exists (`lib/theme/tokens.dart`) - it just needs to be the only source.
