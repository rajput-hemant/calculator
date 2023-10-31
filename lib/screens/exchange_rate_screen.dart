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

  int _firstFieldIndex = 15;
  int _secondFieldIndex = 31;

  void convert() async {
    String from = Currency.currenciesList[_firstFieldIndex].id;
    String to = Currency.currenciesList[_secondFieldIndex].id;

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
  void initState() {
    MoneyConverter.fetchRates().then((rates) {
      setState(() {
        _rates = rates;
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
    final isTabView = ref.watch(prefrencesProvider).tabView;

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
                    list: Currency.currenciesList,
                    isCurrency: true,
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
              onChanged: convert,
            ),
          ),
        ],
      ),
    );
  }
}
