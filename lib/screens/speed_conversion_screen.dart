import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class SpeedConversionScreen extends StatefulWidget {
  const SpeedConversionScreen({super.key});

  @override
  State<SpeedConversionScreen> createState() => _SpeedConversionScreenState();
}

class _SpeedConversionScreenState extends State<SpeedConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "1000");

  bool isFirstFieldSelected = true;
  bool isFirstLabelSelected = true;

  int firstFieldIndex = 1;
  int secondFieldIndex = 2;

  void convert() {
    convertUnit(
      _firstFieldController,
      _secondFieldController,
      firstFieldIndex,
      secondFieldIndex,
      Speed.speedList,
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
          'Speed Conversion',
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
                    list: Speed.speedList,
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
                    list: Speed.speedList,
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
