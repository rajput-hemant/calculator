import 'package:flutter/material.dart';

import '../models/frequency.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class FrequencyConversionScreen extends StatefulWidget {
  const FrequencyConversionScreen({super.key});

  @override
  State<FrequencyConversionScreen> createState() =>
      _FrequencyConversionScreenState();
}

class _FrequencyConversionScreenState extends State<FrequencyConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "0.001");

  bool isFirstFieldSelected = true;
  bool isFirstLabelSelected = true;

  int firstFieldIndex = 0;
  int secondFieldIndex = 1;

  void convert() {
    convertUnit(
      _firstFieldController,
      _secondFieldController,
      firstFieldIndex,
      secondFieldIndex,
      Frequency.frequencyList,
      isFirstFieldSelected,
    );
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
      appBar: AppBar(
        title: const Text(
          'Frequency Conversion',
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
                    list: Frequency.frequencyList,
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
                    list: Frequency.frequencyList,
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
