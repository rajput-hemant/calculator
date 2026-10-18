import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/models/currency.dart';
import 'package:calculator/widgets/currency_badge.dart';

void main() {
  testWidgets('CurrencyBadge renders the country flag for mapped codes', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Tokens.seed, Brightness.light),
        home: Scaffold(body: CurrencyBadge(code: 'USD')),
      ),
    );
    expect(find.text('🇺🇸'), findsOneWidget);
    expect(find.text('USD'), findsNothing);
    expect(find.byType(CircleAvatar), findsNothing);
    final containers = tester.widgetList(find.byType(Container)).toList();
    expect(containers.isNotEmpty, true);
  });

  testWidgets(
    'CurrencyBadge falls back to the monogram for codes without a country',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: buildAppTheme(Tokens.seed, Brightness.light),
          home: Scaffold(body: CurrencyBadge(code: 'XOF')),
        ),
      );
      expect(find.text('XOF'), findsOneWidget);
    },
  );

  testWidgets('CurrencyBadge uses theme container colours', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Tokens.seed, Brightness.light),
        home: Scaffold(body: CurrencyBadge(code: 'INR')),
      ),
    );
    final badge = tester.widget<Container>(find.byType(Container).first);
    expect(badge.decoration, isNotNull);
  });

  test('the country map covers every currency except the stateless ones', () {
    // These are shared by several countries or by none, so no flag exists.
    const stateless = {'ANG', 'XAF', 'XCD', 'XCG', 'XOF', 'XPF'};
    final ids = Currency.currenciesList.map((c) => c.id).toSet();

    expect(
      ids.where((id) => !currencyCountryCodes.containsKey(id)).toSet(),
      stateless,
    );
    expect(
      currencyCountryCodes.keys.toSet().difference(ids),
      isEmpty,
      reason: 'map entry for a currency that no longer exists',
    );
    for (final entry in currencyCountryCodes.entries) {
      expect(
        entry.value,
        matches(RegExp(r'^[A-Z]{2}$')),
        reason: '${entry.key} must map to an alpha-2 country code',
      );
    }
  });
}
