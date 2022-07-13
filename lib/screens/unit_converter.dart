import 'dart:developer';

import 'package:calculator/screens/exchange_rate_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/unit_box.dart';
import '../widgets/unit_icon.dart';

class UnitConverter extends StatelessWidget {
  static const routeName = '/unit-converter';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060606),
      appBar: AppBar(
        title: const Text(
          "Unit converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(const UnitIcon(FontAwesomeIcons.globe, 'Currency'), () {
                  Navigator.pushNamed(context, ExchangeRateScreen.routeName);
                }),
                UnitBox(const UnitIcon(FontAwesomeIcons.ruler, 'Length'), () {
                  log('Length');
                }),
                UnitBox(const UnitIcon(FontAwesomeIcons.chartArea, 'Area'), () {
                  log('Call');
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(const UnitIcon(FontAwesomeIcons.gaugeHigh, 'Speed'),
                    () {
                  log('Call');
                }),
                UnitBox(
                    const UnitIcon(FontAwesomeIcons.weightHanging, 'Weight'),
                    () {
                  log('Call');
                }),
                UnitBox(
                    const UnitIcon(FontAwesomeIcons.temperatureThreeQuarters,
                        'Temperature'), () {
                  log('Call');
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(const UnitIcon(FontAwesomeIcons.bolt, 'Power'), () {
                  log('Call');
                }),
                UnitBox(
                    const UnitIcon(FontAwesomeIcons.gaugeSimple, 'Pressure'),
                    () {
                  log('Call');
                }),
                UnitBox(const UnitIcon(FontAwesomeIcons.cube, 'Volume'), () {
                  log('Call');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
