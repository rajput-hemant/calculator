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

  bool isFirstFieldSelected = true;
  bool isFirstLabelSelected = true;

  int firstFieldIndex = 0;
  int secondFieldIndex = 1;

  void convert() {
    final double inputValue = double.parse(isFirstFieldSelected
        ? _firstFieldController.text
        : _secondFieldController.text);

    double outputValue;

    if (firstFieldIndex == 0 && secondFieldIndex == 1) {
      // Celsius to Fahrenheit
      outputValue = (inputValue * 9 / 5) + 32;
    } else if (firstFieldIndex == 0 && secondFieldIndex == 2) {
      // Celsius to Kelvin
      outputValue = inputValue + 273.15;
    } else if (firstFieldIndex == 0 && secondFieldIndex == 3) {
      // Celsius to Rankine
      outputValue = (inputValue + 273.15) * 9 / 5;
    } else if (firstFieldIndex == 0 && secondFieldIndex == 4) {
      // Celsius to Réaumur
      outputValue = inputValue * 4 / 5;
    } else if (firstFieldIndex == 1 && secondFieldIndex == 0) {
      // Fahrenheit to Celsius
      outputValue = (inputValue - 32) * 5 / 9;
    } else if (firstFieldIndex == 1 && secondFieldIndex == 2) {
      // Fahrenheit to Kelvin
      outputValue = (inputValue - 32) * 5 / 9 + 273.15;
    } else if (firstFieldIndex == 1 && secondFieldIndex == 3) {
      // Fahrenheit to Rankine
      outputValue = inputValue + 459.67;
    } else if (firstFieldIndex == 1 && secondFieldIndex == 4) {
      // Fahrenheit to Réaumur
      outputValue = (inputValue - 32) * 4 / 9;
    } else if (firstFieldIndex == 2 && secondFieldIndex == 0) {
      // Kelvin to Celsius
      outputValue = inputValue - 273.15;
    } else if (firstFieldIndex == 2 && secondFieldIndex == 1) {
      // Kelvin to Fahrenheit
      outputValue = (inputValue - 273.15) * 9 / 5 + 32;
    } else if (firstFieldIndex == 2 && secondFieldIndex == 3) {
      // Kelvin to Rankine
      outputValue = inputValue * 9 / 5;
    } else if (firstFieldIndex == 2 && secondFieldIndex == 4) {
      // Kelvin to Réaumur
      outputValue = (inputValue - 273.15) * 4 / 5;
    } else if (firstFieldIndex == 3 && secondFieldIndex == 0) {
      // Rankine to Celsius
      outputValue = (inputValue - 491.67) * 5 / 9;
    } else if (firstFieldIndex == 3 && secondFieldIndex == 1) {
      // Rankine to Fahrenheit
      outputValue = inputValue - 459.67;
    } else if (firstFieldIndex == 3 && secondFieldIndex == 2) {
      // Rankine to Kelvin
      outputValue = inputValue * 5 / 9;
    } else if (firstFieldIndex == 3 && secondFieldIndex == 4) {
      // Rankine to Réaumur
      outputValue = (inputValue - 491.67) * 4 / 9;
    } else if (firstFieldIndex == 4 && secondFieldIndex == 0) {
      // Réaumur to Celsius
      outputValue = inputValue * 5 / 4;
    } else if (firstFieldIndex == 4 && secondFieldIndex == 1) {
      // Réaumur to Fahrenheit
      outputValue = (inputValue * 9 / 4) + 32;
    } else if (firstFieldIndex == 4 && secondFieldIndex == 2) {
      // Réaumur to Kelvin
      outputValue = (inputValue * 5 / 4) + 273.15;
    } else {
      // Réaumur to Rankine
      outputValue = (inputValue * 9 / 4) + 491.67;
    }

    setState(() {
      if (isFirstFieldSelected) {
        _secondFieldController.text = outputValue.toStringAsFixed(6);
      } else {
        _firstFieldController.text = outputValue.toStringAsFixed(6);
      }
    });
  }

  void changeSelectedIndex(int index) {
    setState(() {
      if (isFirstLabelSelected) {
        firstFieldIndex = index;
      } else {
        secondFieldIndex = index;
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
      appBar: AppBar(title: const Text('Area Conversion')),
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
                    isFieldSelected: isFirstFieldSelected,
                    isLabelSelected: isFirstLabelSelected,
                    fieldIndex: firstFieldIndex,
                    onFieldSelect: () {
                      setState(() {
                        isFirstFieldSelected = true;
                      });
                    },
                    onLabelSelect: () {
                      setState(() {
                        isFirstLabelSelected = true;
                      });
                      convert();
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(),
                  ),
                  FieldListTile(
                    list: Temperature.temperatureList,
                    controller: _secondFieldController,
                    isFieldSelected: !isFirstFieldSelected,
                    isLabelSelected: !isFirstLabelSelected,
                    fieldIndex: secondFieldIndex,
                    onFieldSelect: () {
                      setState(() {
                        isFirstFieldSelected = false;
                      });
                    },
                    onLabelSelect: () {
                      setState(() {
                        isFirstLabelSelected = false;
                      });
                      convert();
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Keypad(
              controller: isFirstFieldSelected
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
