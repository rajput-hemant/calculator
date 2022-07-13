import 'package:flutter/material.dart';

import '../models/currency.dart';
import '../widgets.dart/round_button.dart';

class ExchangeRateScreen extends StatefulWidget {
  static const routeName = '/exchange-rate';
  const ExchangeRateScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  final _currencyList = CurrenciesData.currenciesData;
  bool _isFirstField = true;
  int _firstFieldIndex = 0, _secondFieldIndex = 17;
  dynamic _firstField = '0', _secondField = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Currency'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    title: GestureDetector(
                      child: Text(
                          CurrenciesData.currenciesData[_firstFieldIndex].name),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          builder: (_) {
                            return DraggableScrollableSheet(
                              expand: false,
                              maxChildSize: 0.95,
                              initialChildSize: 0.9,
                              builder: (context, scrollController) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Select Currency",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Divider(),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          // controller: controller,
                                          itemCount: _currencyList.length,
                                          itemBuilder: (context, i) {
                                            return ListTile(
                                              title: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _firstFieldIndex = i;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    Text(_currencyList[i].name),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    subtitle: Text(_currencyList[_firstFieldIndex].id),
                    trailing: InkWell(
                      onTap: () {
                        _isFirstField = true;
                        _firstField = '0';
                      },
                      child: Text(
                        _firstField,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 15,
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: GestureDetector(
                      child: Text(CurrenciesData
                          .currenciesData[_secondFieldIndex].name),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          builder: (_) {
                            return DraggableScrollableSheet(
                              expand: false,
                              maxChildSize: 0.95,
                              initialChildSize: 0.9,
                              builder: (context, scrollController) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Select Currency",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Divider(),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          // controller: controller,
                                          itemCount: _currencyList.length,
                                          itemBuilder: (context, i) {
                                            return ListTile(
                                              title: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _secondFieldIndex = i;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    Text(_currencyList[i].name),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    subtitle: Text(_currencyList[_secondFieldIndex].id),
                    trailing: InkWell(
                      onTap: () {
                        _isFirstField = false;
                        _secondField = '0';
                      },
                      child: Text(
                        _secondField,
                        style: const TextStyle(fontSize: 24),
                      ),
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
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black12,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundButton(buttonText: '7', onPressed: () {}),
                      RoundButton(buttonText: '8', onPressed: () {}),
                      RoundButton(buttonText: '9', onPressed: () {}),
                      RoundButton(buttonText: 'C', onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundButton(buttonText: '4', onPressed: () {}),
                      RoundButton(buttonText: '5', onPressed: () {}),
                      RoundButton(buttonText: '6', onPressed: () {}),
                      RoundButton(buttonText: 'Del', onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundButton(buttonText: '1', onPressed: () {}),
                      RoundButton(buttonText: '2', onPressed: () {}),
                      RoundButton(buttonText: '3', onPressed: () {}),
                      RoundButton(
                        buttonText: '',
                        onPressed: () {},
                        backgroundColor: Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundButton(
                        buttonText: '00',
                        onPressed: () {},
                      ),
                      RoundButton(buttonText: '0', onPressed: () {}),
                      RoundButton(
                        buttonText: '.',
                        onPressed: () {},
                      ),
                      RoundButton(
                        buttonText: '',
                        backgroundColor: Colors.black,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
