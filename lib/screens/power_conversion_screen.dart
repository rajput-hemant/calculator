import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../provider/preferences_provider.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class PowerConversionScreen extends ConsumerStatefulWidget {
  const PowerConversionScreen({super.key});

  @override
  ConsumerState<PowerConversionScreen> createState() =>
      _PowerConversionScreenState();
}

class _PowerConversionScreenState extends ConsumerState<PowerConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "735.56214");

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  void convert() {
    final [firstFieldIndex, secondFieldIndex] =
        ref.read(prefrencesProvider).unitIndexes[Units.power]!;

    setState(() {
      convertUnit(
        _firstFieldController,
        _secondFieldController,
        firstFieldIndex,
        secondFieldIndex,
        Power.powerList,
        _isFirstFieldSelected,
      );
    });
  }

  void changeSelectedIndex(int index) {
    final [firstFieldIndex, secondFieldIndex] =
        ref.watch(prefrencesProvider).unitIndexes[Units.power]!;

    ref.read(prefrencesProvider.notifier).setUnitIndexes(
          Units.power,
          _isFirstLabelSelected
              ? [index, secondFieldIndex]
              : [firstFieldIndex, index],
        );

    convert();
  }

  @override
  void initState() {
    convert();
    super.initState();
  }

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final [firstFieldIndex, secondFieldIndex] =
        ref.watch(prefrencesProvider).unitIndexes[Units.power]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Power Conversion',
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
                    list: Power.powerList,
                    controller: _firstFieldController,
                    isFieldSelected: _isFirstFieldSelected,
                    isLabelSelected: _isFirstLabelSelected,
                    fieldIndex: firstFieldIndex,
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
                    list: Power.powerList,
                    controller: _secondFieldController,
                    isFieldSelected: !_isFirstFieldSelected,
                    isLabelSelected: !_isFirstLabelSelected,
                    fieldIndex: secondFieldIndex,
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
