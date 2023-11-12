import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../provider/preferences_provider.dart';
import '../utils/money_coverter.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class ExchangeRateScreen extends ConsumerStatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  ConsumerState<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends ConsumerState<ExchangeRateScreen> {
  late Map<String, dynamic> _rates;
  String _lastUpdated = "-";

  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "0.01");

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  void convert(int firstFieldIndex, int secondFieldIndex) async {
    String from = Currency.currenciesList[firstFieldIndex].id;
    String to = Currency.currenciesList[secondFieldIndex].id;

    try {
      double amount = double.parse(_isFirstFieldSelected
          ? _firstFieldController.text
          : _secondFieldController.text);

      double rate = _isFirstFieldSelected
          ? _rates["data"][to] / _rates["data"][from]
          : _rates["data"][from] / _rates["data"][to];

      setState(() {
        if (_isFirstFieldSelected) {
          _secondFieldController.text = (amount * rate).toStringAsFixed(2);
        } else {
          _firstFieldController.text = (amount * rate).toStringAsFixed(2);
        }
      });
    } catch (e) {
      // clear the text fields on invalid double error,
      // which is thrown when any one of the text fields is empty/cleared
      _firstFieldController.clear();
      _secondFieldController.clear();
    }
  }

  void changeSelectedIndex(int index) {
    final [firstFieldIndex, secondFieldIndex] =
        ref.watch(prefrencesProvider).unitIndexes[Units.currency]!;

    ref.read(prefrencesProvider.notifier).setUnitIndexes(
          Units.currency,
          _isFirstLabelSelected
              ? [index, secondFieldIndex]
              : [firstFieldIndex, index],
        );

    _isFirstFieldSelected
        ? convert(firstFieldIndex, index)
        : convert(index, secondFieldIndex);
  }

  @override
  void initState() {
    MoneyConverter.fetchRates().then((rates) {
      setState(() {
        _rates = rates;

        final [firstFieldIndex, secondFieldIndex] =
            ref.read(prefrencesProvider).unitIndexes[Units.currency]!;
        convert(firstFieldIndex, secondFieldIndex);
      });
    });

    SharedPreferences.getInstance().then((prefs) {
      final lastUpdated = prefs.getInt("lastUpdated");
      if (lastUpdated != null) {
        setState(() {
          String formattedDateTime = DateFormat('MMMM d, y, h:mm a')
              .format(DateTime.fromMillisecondsSinceEpoch(lastUpdated));

          _lastUpdated = formattedDateTime;
        });
      }
    });

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
    final prefs = ref.watch(prefrencesProvider);
    final isTabView = prefs.tabView;
    final [firstFieldIndex, secondFieldIndex] =
        prefs.unitIndexes[Units.currency]!;

    return Scaffold(
      appBar: isTabView
          ? null
          : AppBar(
              title: const Text(
                'Currency Conversion',
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
                    list: Currency.currenciesList,
                    isCurrency: true,
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
                      convert(firstFieldIndex, secondFieldIndex);
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                  const SizedBox(height: 16),
                  FieldListTile(
                    list: Currency.currenciesList,
                    isCurrency: true,
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
                      convert(firstFieldIndex, secondFieldIndex);
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "Last Upadated: $_lastUpdated",
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Keypad(
              controller: _isFirstFieldSelected
                  ? _firstFieldController
                  : _secondFieldController,
              onChanged: () => convert(firstFieldIndex, secondFieldIndex),
            ),
          ),
        ],
      ),
    );
  }
}
