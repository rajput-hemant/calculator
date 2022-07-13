import 'package:flutter/material.dart';

import '../models/currency.dart';

class CurrencyTile extends StatelessWidget {
  final List<CurrenciesData> currencyList;
  final int currencyIndex;
  final VoidCallback onSelectingCurrency;

  const CurrencyTile({
    super.key,
    required this.currencyList,
    required this.currencyIndex,
    required this.onSelectingCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: onSelectingCurrency,
        child: Text(currencyList[currencyIndex].name),
      ),
    );
  }
}
