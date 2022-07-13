import 'package:calculator/models/speed.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_sheet_tile.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad_builder.dart';

class SpeedConversionScreen extends StatefulWidget {
  static const routeName = '/speed-conversion-screen';
  const SpeedConversionScreen({Key? key}) : super(key: key);

  @override
  State<SpeedConversionScreen> createState() => _SpeedConversionScreenState();
}

class _SpeedConversionScreenState extends State<SpeedConversionScreen> {
  final _speedList = Speed.speed;
  bool _isFirstField = true;
  int _firstFieldIndex = 1, _secondFieldIndex = 3;
  dynamic _firstField = '0', _secondField = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      appBar: AppBar(
        title: const Text(
          'Speed Conversion',
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
                    fieldTitle: _speedList[_firstFieldIndex].name,
                    index: _firstFieldIndex,
                    list: _speedList,
                    bottomSheetHeader: "Select Unit",
                    onTappingField: () {
                      _isFirstField = true;
                      _secondField = '0';
                    },
                    child: ListView.builder(
                      itemCount: _speedList.length,
                      itemBuilder: (context, i) {
                        return BottomSheetTile(
                          index: i,
                          list: _speedList,
                          onSelecting: () {
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
                    fieldTitle: _speedList[_secondFieldIndex].name,
                    index: _secondFieldIndex,
                    list: _speedList,
                    bottomSheetHeader: "Select Unit",
                    onTappingField: () {
                      _isFirstField = false;
                      _firstField = '0';
                    },
                    child: ListView.builder(
                      itemCount: _speedList.length,
                      itemBuilder: (context, i) {
                        return BottomSheetTile(
                          index: i,
                          list: _speedList,
                          onSelecting: () {
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
            onPressedDot: () => decimalButton(),
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
    var result = (amount / _speedList[from].rate) * _speedList[to].rate;
    setState(() {
      if (_isFirstField) {
        _secondField = result.toStringAsFixed(2);
      } else {
        _firstField = result.toStringAsFixed(2);
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
