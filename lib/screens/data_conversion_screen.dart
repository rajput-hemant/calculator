import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../provider/preferences_provider.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class DataConversionScreen extends ConsumerStatefulWidget {
  const DataConversionScreen({super.key});

  @override
  ConsumerState<DataConversionScreen> createState() =>
      _DataConversionScreenState();
}

class _DataConversionScreenState extends ConsumerState<DataConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "1024");

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  void convert() {
    final [firstFieldIndex, secondFieldIndex] =
        ref.read(prefrencesProvider).unitIndexes[Units.data]!;

    setState(() {
      convertUnit(
        _firstFieldController,
        _secondFieldController,
        firstFieldIndex,
        secondFieldIndex,
        Data.dataList,
        _isFirstFieldSelected,
      );
    });
  }

  void changeSelectedIndex(int index) {
    final [firstFieldIndex, secondFieldIndex] =
        ref.watch(prefrencesProvider).unitIndexes[Units.data]!;

    ref.read(prefrencesProvider.notifier).setUnitIndexes(
          Units.data,
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
        ref.watch(prefrencesProvider).unitIndexes[Units.data]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Conversion',
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
                    list: Data.dataList,
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
                    list: Data.dataList,
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
