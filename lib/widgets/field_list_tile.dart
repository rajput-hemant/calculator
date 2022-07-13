import 'package:flutter/material.dart';

import '../models/currency.dart';
import 'scrollable_sheet.dart';

class FieldListTile extends StatelessWidget {
  final Widget child;
  final int index;
  final dynamic field;
  final String bottomSheetHeader;
  final VoidCallback onTappingAmount;
  final List<CurrenciesData> currencyList;

  const FieldListTile({
    super.key,
    required this.index,
    required this.field,
    required this.onTappingAmount,
    required this.currencyList,
    required this.child,
    required this.bottomSheetHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        child: Text(CurrenciesData.currenciesData[index].name),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (_) {
              return ScrollableSheet(
                sheetHeader: bottomSheetHeader,
                listViewBuilder: child,
              );
            },
          );
        },
      ),
      subtitle: Text(currencyList[index].id),
      trailing: InkWell(
        onTap: onTappingAmount,
        child: Text(
          field,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
