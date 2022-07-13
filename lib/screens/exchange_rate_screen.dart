import 'package:flutter/material.dart';

import '../models/currency.dart';
import '../utils/money_converter.dart';
import '../widgets/currency_tile.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad_builder.dart';

class ExchangeRateScreen extends StatefulWidget {
  static const routeName = '/exchange-rate';
  const ExchangeRateScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  final _currencyList = CurrenciesData.currenciesData;
  bool _isFirstField = true;
  int _firstFieldIndex = 0, _secondFieldIndex = 17;
  dynamic _firstField = '0', _secondField = '0';

  void convert({
    required String from,
    required String to,
    required double amount,
  }) async {
    var result = await MoneyConverter.convert(
        Currency(from, amount: amount), Currency(to));
    setState(() {
      if (_isFirstField) {
        _secondField = result.toStringAsFixed(2);
      } else {
        _firstField = result.toStringAsFixed(2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      appBar: AppBar(
        title: const Text('Currency'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  FieldListTile(
                    field: _firstField,
                    index: _firstFieldIndex,
                    currencyList: _currencyList,
                    bottomSheetHeader: "Select Currency",
                    onTappingAmount: onTappingAmount,
                    child: ListView.builder(
                      itemCount: _currencyList.length,
                      itemBuilder: (context, i) {
                        return CurrencyTile(
                          currencyIndex: i,
                          currencyList: _currencyList,
                          onSelectingCurrency: () {
                            setState(() => _firstFieldIndex = i);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 15,
                    color: Colors.grey,
                  ),
                  FieldListTile(
                    field: _secondField,
                    index: _secondFieldIndex,
                    currencyList: _currencyList,
                    bottomSheetHeader: "Select Currency",
                    onTappingAmount: onTappingAmount,
                    child: ListView.builder(
                      itemCount: _currencyList.length,
                      itemBuilder: (context, i) {
                        return CurrencyTile(
                          currencyIndex: i,
                          currencyList: _currencyList,
                          onSelectingCurrency: () {
                            setState(() => _secondFieldIndex = i);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          KeyPad(
            onPressed0: () => onPressed(strToConcate: "0"),
            onPressed1: () => onPressed(strToConcate: "1"),
            onPressed2: () => onPressed(strToConcate: "2"),
            onPressed3: () => onPressed(strToConcate: "3"),
            onPressed4: () => onPressed(strToConcate: "4"),
            onPressed5: () => onPressed(strToConcate: "5"),
            onPressed6: () => onPressed(strToConcate: "6"),
            onPressed7: () => onPressed(strToConcate: "7"),
            onPressed8: () => onPressed(strToConcate: "8"),
            onPressed9: () => onPressed(strToConcate: "9"),
            onPressed00: () => onPressed(strToConcate: "00"),
            onPressedDot: () => onPressed(strToConcate: "."),
            onPressedDel: deleteButton,
            onPressedClear: clearButton,
            onPressedConvert: convertButton,
          )
        ],
      ),
    );
  }

  void onTappingAmount() {
    _isFirstField = true;
    _firstField = '0';
  }

  void convertButton() {
    return setState(() {
      if (_isFirstField) {
        convert(
          from: _currencyList[_firstFieldIndex].id,
          to: _currencyList[_secondFieldIndex].id,
          amount: double.parse(_firstField),
        );
      } else {
        convert(
          from: _currencyList[_secondFieldIndex].id,
          to: _currencyList[_firstFieldIndex].id,
          amount: double.parse(_secondField),
        );
      }
    });
  }

  void decimalButton() {
    return setState(() {
      if (_isFirstField && !_firstField.toString().contains(".")) {
        _firstField = double.parse(_firstField + '.').toString();
      } else if (!_isFirstField && !_secondField.toString().contains(".")) {
        _secondField = double.parse(_secondField + '.').toString();
      }
    });
  }

  void clearButton() {
    return setState(
      () {
        _firstField = '0';
        _secondField = '0';
      },
    );
  }

  void deleteButton() {
    return setState(() {
      if (_isFirstField) {
        if (_firstField.length == 1) {
          _firstField = '0';
          _secondField = '0';
        } else {
          _firstField = _firstField.substring(0, _firstField.length - 1);
        }
      } else {
        if (_secondField.length == 1) {
          _firstField = '0';
          _secondField = '0';
        } else {
          _secondField = _secondField.substring(0, _secondField.length - 1);
        }
      }
    });
  }

  void onPressed({String? strToConcate}) {
    return setState(
      () {
        if (_isFirstField) {
          if (_firstField == '0.0') {
            _firstField = strToConcate!;
          } else {
            if (strToConcate == "00") {
              _firstField = (int.parse(_firstField) * 100).toString();
            } else if (strToConcate == '0') {
              _firstField = (int.parse(_firstField) * 10).toString();
            } else {
              if (_firstField.toString().contains('.')) {
                _firstField =
                    (double.parse(_firstField + strToConcate!)).toString();
              } else {
                _firstField =
                    (int.parse(_firstField + strToConcate!)).toString();
              }
            }
          }
        } else {
          if (_secondField == '0.0') {
            _secondField = strToConcate!;
          } else {
            if (strToConcate == "00") {
              _secondField = (int.parse(_secondField) * 100).toString();
            } else if (strToConcate == '0') {
              _secondField = (int.parse(_secondField) * 10).toString();
            } else {
              if (_firstField.toString().contains('.')) {
                _secondField =
                    (double.parse(_secondField + strToConcate!)).toString();
              } else {
                _secondField =
                    (int.parse(_secondField + strToConcate!)).toString();
              }
            }
          }
        }
      },
    );
  }
}
