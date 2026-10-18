import 'package:flutter/material.dart';

import '../models/currency.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';

/// Currency badge. Shows the flag emoji derived from the ISO country in
/// [currencyCountryCodes], or the monogram (e.g. XOF) when the currency has no
/// representative country, inside a fill circle.
class CurrencyBadge extends StatelessWidget {
  const CurrencyBadge({super.key, required this.code});

  final String code;

  /// Regional indicator symbols: each ASCII letter renders as its flag letter.
  static String _flagFromCountry(String country) => String.fromCharCodes(
    country.codeUnits.map((unit) => 0x1F1E6 + (unit - 0x41)),
  );

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final country = currencyCountryCodes[code];
    return Container(
      width: 28,
      height: 28,
      decoration: ShapeDecoration(
        color: p.fill,
        shape: AppShapes.of(context).border(14),
      ),
      alignment: Alignment.center,
      child: country != null
          ? Text(
              _flagFromCountry(country),
              semanticsLabel: country,
              style: AppText.body,
            )
          : Text(
              code,
              style: TextStyle(
                color: p.label,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
    );
  }
}
