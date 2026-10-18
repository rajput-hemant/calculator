import 'package:calculator/models/models.dart';
import 'package:calculator/theme/app_icons.dart';
import 'package:calculator/widgets/field_list_tile.dart';
import 'package:calculator/widgets/controls.dart';
import 'package:calculator/widgets/select_unit_sheet.dart';
import 'package:calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> openSheet(
    WidgetTester tester, {
    required void Function(int) onPicked,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: buildAppTheme(Tokens.seed, Brightness.light),
        home: Scaffold(
          body: FieldListTile(
            controller: TextEditingController(),
            list: Currency.currenciesList,
            isCurrency: true,
            title: 'Currency',
            isFieldSelected: false,
            onFieldSelect: () {},
            onLabelSelect: () {},
            fieldIndex: 31,
            changeSelectedIndex: onPicked,
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(AppIcons.expand));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'the pill opens a bottom sheet that returns the original list index',
    (tester) async {
      int? picked;
      await openSheet(tester, onPicked: (i) => picked = i);

      // Floating sheet at about 70% of the screen, not the whole one.
      expect(find.byType(SelectUnitSheet), findsOneWidget);
      final sheetHeight = tester.getSize(find.byType(SelectUnitSheet)).height;
      expect(sheetHeight, 600 * 0.7);
      expect(find.byTooltip('Close'), findsOneWidget);

      // Display is name-sorted, so the alphabetically first row leads.
      final firstRow = tester.getTopLeft(find.textContaining('Afghan Afghani'));
      final secondRow = tester.getTopLeft(find.textContaining('Albanian Lek'));
      expect(firstRow.dy, lessThan(secondRow.dy));

      // Flag sits to the left of the name in the row.
      final flag = tester.getTopLeft(find.text('🇦🇫'));
      expect(flag.dx, lessThan(firstRow.dx));

      // Tapping the sorted row still resolves to its true index in the list.
      await tester.tap(find.textContaining('Afghan Afghani'));
      await tester.pumpAndSettle();

      expect(picked, Currency.currenciesList.indexWhere((c) => c.id == 'AFN'));
    },
  );

  testWidgets('search matches the currency code, not only the name', (
    tester,
  ) async {
    int? picked;
    await openSheet(tester, onPicked: (i) => picked = i);

    // XOF appears only in the id; the name is West African CFA Franc.
    final searchField = find.descendant(
      of: find.byType(SearchField),
      matching: find.byType(EditableText),
    );
    await tester.enterText(searchField, 'xof');
    await tester.pumpAndSettle();

    expect(find.textContaining('West African CFA Franc'), findsOneWidget);
    expect(find.textContaining('Afghan Afghani'), findsNothing);

    await tester.tap(find.textContaining('West African CFA Franc'));
    await tester.pumpAndSettle();

    expect(picked, Currency.currenciesList.indexWhere((c) => c.id == 'XOF'));
  });
}
