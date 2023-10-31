import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class TemperatureConversionScreen extends StatefulWidget {
  const TemperatureConversionScreen({super.key});

  @override
  State<TemperatureConversionScreen> createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "0.0001");

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  int _firstFieldIndex = 0;
  int _secondFieldIndex = 1;

  void convert() {
    final double inputValue = double.parse(_isFirstFieldSelected
        ? _firstFieldController.text
        : _secondFieldController.text);

    double outputValue;

    if (_firstFieldIndex == 0 && _secondFieldIndex == 1) {
      // Celsius to Fahrenheit
      outputValue = (inputValue * 9 / 5) + 32;
    } else if (_firstFieldIndex == 0 && _secondFieldIndex == 2) {
      // Celsius to Kelvin
      outputValue = inputValue + 273.15;
    } else if (_firstFieldIndex == 0 && _secondFieldIndex == 3) {
      // Celsius to Rankine
      outputValue = (inputValue + 273.15) * 9 / 5;
    } else if (_firstFieldIndex == 0 && _secondFieldIndex == 4) {
      // Celsius to Réaumur
      outputValue = inputValue * 4 / 5;
    } else if (_firstFieldIndex == 1 && _secondFieldIndex == 0) {
      // Fahrenheit to Celsius
      outputValue = (inputValue - 32) * 5 / 9;
    } else if (_firstFieldIndex == 1 && _secondFieldIndex == 2) {
      // Fahrenheit to Kelvin
      outputValue = (inputValue - 32) * 5 / 9 + 273.15;
    } else if (_firstFieldIndex == 1 && _secondFieldIndex == 3) {
      // Fahrenheit to Rankine
      outputValue = inputValue + 459.67;
    } else if (_firstFieldIndex == 1 && _secondFieldIndex == 4) {
      // Fahrenheit to Réaumur
      outputValue = (inputValue - 32) * 4 / 9;
    } else if (_firstFieldIndex == 2 && _secondFieldIndex == 0) {
      // Kelvin to Celsius
      outputValue = inputValue - 273.15;
    } else if (_firstFieldIndex == 2 && _secondFieldIndex == 1) {
      // Kelvin to Fahrenheit
      outputValue = (inputValue - 273.15) * 9 / 5 + 32;
    } else if (_firstFieldIndex == 2 && _secondFieldIndex == 3) {
      // Kelvin to Rankine
      outputValue = inputValue * 9 / 5;
    } else if (_firstFieldIndex == 2 && _secondFieldIndex == 4) {
      // Kelvin to Réaumur
      outputValue = (inputValue - 273.15) * 4 / 5;
    } else if (_firstFieldIndex == 3 && _secondFieldIndex == 0) {
      // Rankine to Celsius
      outputValue = (inputValue - 491.67) * 5 / 9;
    } else if (_firstFieldIndex == 3 && _secondFieldIndex == 1) {
      // Rankine to Fahrenheit
      outputValue = inputValue - 459.67;
    } else if (_firstFieldIndex == 3 && _secondFieldIndex == 2) {
      // Rankine to Kelvin
      outputValue = inputValue * 5 / 9;
    } else if (_firstFieldIndex == 3 && _secondFieldIndex == 4) {
      // Rankine to Réaumur
      outputValue = (inputValue - 491.67) * 4 / 9;
    } else if (_firstFieldIndex == 4 && _secondFieldIndex == 0) {
      // Réaumur to Celsius
      outputValue = inputValue * 5 / 4;
    } else if (_firstFieldIndex == 4 && _secondFieldIndex == 1) {
      // Réaumur to Fahrenheit
      outputValue = (inputValue * 9 / 4) + 32;
    } else if (_firstFieldIndex == 4 && _secondFieldIndex == 2) {
      // Réaumur to Kelvin
      outputValue = (inputValue * 5 / 4) + 273.15;
    } else {
      // Réaumur to Rankine
      outputValue = (inputValue * 9 / 4) + 491.67;
    }

    setState(() {
      if (_isFirstFieldSelected) {
        _secondFieldController.text = outputValue.toStringAsFixed(6);
      } else {
        _firstFieldController.text = outputValue.toStringAsFixed(6);
      }
    });
  }

  void changeSelectedIndex(int index) {
    setState(() {
      if (_isFirstLabelSelected) {
        _firstFieldIndex = index;
      } else {
        _secondFieldIndex = index;
      }
    });

    convert();
  }

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Area Conversion',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  FieldListTile(
                    list: Temperature.temperatureList,
                    controller: _firstFieldController,
                    isFieldSelected: _isFirstFieldSelected,
                    isLabelSelected: _isFirstLabelSelected,
                    fieldIndex: _firstFieldIndex,
                    onFieldSelect: () {
                      setState(() {
                        _isFirstFieldSelected = true;
                      });
                    },
                    onLabelSelect: () {
                      setState(() {
                        _isFirstLabelSelected = true;
                      });
                      convert();
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                  const SizedBox(height: 16),
                  FieldListTile(
                    list: Temperature.temperatureList,
                    controller: _secondFieldController,
                    isFieldSelected: !_isFirstFieldSelected,
                    isLabelSelected: !_isFirstLabelSelected,
                    fieldIndex: _secondFieldIndex,
                    onFieldSelect: () {
                      setState(() {
                        _isFirstFieldSelected = false;
                      });
                    },
                    onLabelSelect: () {
                      setState(() {
                        _isFirstLabelSelected = false;
                      });
                      convert();
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Keypad(
              controller: _isFirstFieldSelected
                  ? _firstFieldController
                  : _secondFieldController,
              onChanged: convert,
            ),
          ),
        ],
      ),
    );
  }
}
