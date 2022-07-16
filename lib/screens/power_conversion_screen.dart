import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/power.dart';
import '../widgets/bottom_sheet_tile.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad_builder.dart';

class PowerConversionScreen extends StatefulWidget {
  static const routeName = '/power-conversion-screen';
  const PowerConversionScreen({Key? key}) : super(key: key);

  @override
  State<PowerConversionScreen> createState() => _PowerConversionScreenState();
}

class _PowerConversionScreenState extends State<PowerConversionScreen> {
  final _powerList = Power.power;
  bool _isFirstField = true;
  int _firstFieldIndex = 9, _secondFieldIndex = 6;
  dynamic _firstField = '0', _secondField = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Power Conversion',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
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
                    isSelectedField: _isFirstField,
                    index: _firstFieldIndex,
                    title: _powerList[_firstFieldIndex].name,
                    subtitle: _powerList[_firstFieldIndex].id,
                    bottomSheetHeader: "Select Unit",
                    onTappingField: () {
                      setState(() => _isFirstField = true);
                      clearButton();
                    },
                    child: ListView.builder(
                      itemCount: _powerList.length,
                      itemBuilder: (context, i) {
                        return BottomSheetTile(
                          index: i,
                          list: _powerList,
                          onSelecting: () {
                            setState(() => _firstFieldIndex = i);
                            log("First Field Index: $_firstFieldIndex");
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  FieldListTile(
                    field: _secondField,
                    isSelectedField: !_isFirstField,
                    index: _secondFieldIndex,
                    title: _powerList[_secondFieldIndex].name,
                    subtitle: _powerList[_secondFieldIndex].id,
                    bottomSheetHeader: "Select Unit",
                    onTappingField: () {
                      setState(() => _isFirstField = false);
                      clearButton();
                    },
                    child: ListView.builder(
                      itemCount: _powerList.length,
                      itemBuilder: (context, i) {
                        return BottomSheetTile(
                          index: i,
                          list: _powerList,
                          onSelecting: () {
                            setState(() => _secondFieldIndex = i);
                            log("Second Field Index: $_secondFieldIndex");
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
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
            onPressedDot: decimalButton,
            onPressedDel: deleteButton,
            onPressedClear: clearButton,
            onPressedConvert: convertButton,
          )
        ],
      ),
    );
  }

  void convert({
    required int from,
    required int to,
    required double amount,
  }) {
    var result = (amount / _powerList[from].rate) * _powerList[to].rate;
    setState(() {
      if (_isFirstField) {
        if (result.toString().length > 8) {
          _secondField = result.toStringAsFixed(6);
        } else {
          _secondField = result.toString();
        }
      } else {
        if (result.toString().length > 8) {
          _firstField = result.toStringAsFixed(6);
        } else {
          _firstField = result.toString();
        }
      }
    });
  }

  void convertButton() {
    return setState(() {
      if (_isFirstField) {
        convert(
          from: _firstFieldIndex,
          to: _secondFieldIndex,
          amount: double.parse(_firstField),
        );
      } else {
        convert(
          from: _secondFieldIndex,
          to: _firstFieldIndex,
          amount: double.parse(_secondField),
        );
      }
    });
  }

  void decimalButton() {
    return setState(() {
      if (_isFirstField && !_firstField.toString().contains(".")) {
        _firstField += '.';
      } else if (!_isFirstField && !_secondField.toString().contains(".")) {
        _secondField += '.';
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
          if (_firstField == '0.0' ||
              _firstField == '00' ||
              _firstField == '0') {
            _firstField = strToConcate!;
          } else {
            if (strToConcate == "00") {
              _firstField += '00';
            } else if (strToConcate == '0') {
              _firstField += '0';
            } else {
              _firstField += strToConcate;
            }
          }
        } else {
          if (_secondField == '0.0' ||
              _secondField == '00' ||
              _secondField == '0') {
            _secondField = strToConcate!;
          } else {
            if (strToConcate == "00") {
              _secondField += '00';
            } else if (strToConcate == '0') {
              _secondField += '0';
            } else {
              _secondField += strToConcate;
            }
          }
        }
      },
    );
  }
}
