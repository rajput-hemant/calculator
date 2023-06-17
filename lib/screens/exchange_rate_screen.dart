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

  bool isFirstFieldSelected = true;
  bool isFirstLabelSelected = true;

  int firstFieldIndex = 15;
  int secondFieldIndex = 31;

  void convert() async {
    String from = Currency.currenciesList[firstFieldIndex].id;
    String to = Currency.currenciesList[secondFieldIndex].id;

    try {
      double amount = double.parse(isFirstFieldSelected
          ? _firstFieldController.text
          : _secondFieldController.text);

      double rate = isFirstFieldSelected
          ? _rates["data"][to] / _rates["data"][from]
          : _rates["data"][from] / _rates["data"][to];

      setState(() {
        if (isFirstFieldSelected) {
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
      if (isFirstLabelSelected) {
        firstFieldIndex = index;
      } else {
        secondFieldIndex = index;
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
                    child: Divider(thickness: 0.5),
                  ),
                  FieldListTile(
                    list: Currency.currenciesList,
                    isCurrency: true,
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
                    child: Divider(thickness: 0.5),
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
