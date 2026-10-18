import 'package:calculator/main.dart';
import 'package:calculator/theme/app_icons.dart';
import 'package:calculator/screens/history_screen.dart';
import 'package:calculator/screens/unit_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('launch lands on the calculator with header actions', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: Calculator()));
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byIcon(AppIcons.history), findsOneWidget);
    expect(find.byIcon(AppIcons.convert), findsOneWidget);
    expect(find.byIcon(AppIcons.scientific), findsOneWidget);
    expect(find.byIcon(AppIcons.more), findsOneWidget);

    final historyCenter = tester.getCenter(find.byIcon(AppIcons.history)).dx;
    final convertCenter = tester.getCenter(find.byIcon(AppIcons.convert)).dx;
    final functionsCenter = tester
        .getCenter(find.byIcon(AppIcons.scientific))
        .dx;
    final menuCenter = tester.getCenter(find.byIcon(AppIcons.more)).dx;
    expect(historyCenter, lessThan(convertCenter));
    expect(convertCenter, lessThan(functionsCenter));
    expect(functionsCenter, lessThan(menuCenter));

    await tester.tap(find.byIcon(AppIcons.history));
    await tester.pumpAndSettle();
    expect(find.byType(HistoryScreen), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(AppIcons.convert));
    await tester.pumpAndSettle();
    expect(find.byType(UnitConverterScreen), findsOneWidget);
  });
}
