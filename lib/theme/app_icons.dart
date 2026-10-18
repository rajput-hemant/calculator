import 'package:flutter/material.dart';

/// Icons from the bundled Material Symbols Rounded subset (assets/fonts). A
/// glyph outside the subset renders as tofu, so add it to the subset first.
const _font = 'MaterialSymbolsRounded';

/// Chrome icons, in one place so every screen uses the same glyph.
abstract final class AppIcons {
  static const IconData back = IconData(
    0xe5c4,
    fontFamily: _font,
  ); // arrow_back
  static const IconData close = IconData(0xe5cd, fontFamily: _font);
  static const IconData check = IconData(0xe668, fontFamily: _font);
  static const IconData chevronRight = IconData(0xe5cc, fontFamily: _font);
  static const IconData expand = IconData(
    0xe5cf,
    fontFamily: _font,
  ); // expand_more
  static const IconData more = IconData(0xe5d4, fontFamily: _font); // more_vert
  static const IconData history = IconData(0xe8b3, fontFamily: _font);
  static const IconData convert = IconData(
    0xe41c,
    fontFamily: _font,
  ); // straighten
  static const IconData scientific = IconData(
    0xf866,
    fontFamily: _font,
  ); // function
  static const IconData search = IconData(0xef7a, fontFamily: _font);
  static const IconData swap = IconData(0xe8d5, fontFamily: _font); // swap_vert
  static const IconData backspace = IconData(0xe14a, fontFamily: _font);
  static const IconData refresh = IconData(0xe5d5, fontFamily: _font);
  static const IconData openExternal = IconData(
    0xe89e,
    fontFamily: _font,
  ); // open_in_new
  static const IconData settings = IconData(0xe8b8, fontFamily: _font);
  static const IconData info = IconData(0xe88e, fontFamily: _font);
  static const IconData code = IconData(0xe86f, fontFamily: _font);
  static const IconData bug = IconData(0xe868, fontFamily: _font); // bug_report
  static const IconData licenses = IconData(
    0xe873,
    fontFamily: _font,
  ); // description
  static const IconData haptics = IconData(
    0xf2cb,
    fontFamily: _font,
  ); // vibration

  static const IconData currencyExchange = IconData(0xeb70, fontFamily: _font);
  static const IconData thermostat = IconData(0xf076, fontFamily: _font);
  static const IconData scale = IconData(0xeb5f, fontFamily: _font);
  static const IconData squareFoot = IconData(0xea49, fontFamily: _font);
  static const IconData waterDrop = IconData(0xe798, fontFamily: _font);
  static const IconData speed = IconData(0xe9e4, fontFamily: _font);
  static const IconData storage = IconData(0xe1db, fontFamily: _font);
  static const IconData bolt = IconData(0xea0b, fontFamily: _font);
  static const IconData localFireDepartment = IconData(
    0xef55,
    fontFamily: _font,
  );
  static const IconData compress = IconData(0xe94d, fontFamily: _font);
  static const IconData schedule = IconData(0xefd6, fontFamily: _font);
  static const IconData architecture = IconData(0xea3b, fontFamily: _font);
  static const IconData graphicEq = IconData(0xe1b8, fontFamily: _font);
  static const IconData localGasStation = IconData(0xe546, fontFamily: _font);
}
