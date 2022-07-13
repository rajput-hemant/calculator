import 'dart:developer';

import 'package:calculator/screens/exchange_rate_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/unit_box.dart';
import '../widgets/unit_icon.dart';

class UnitConverter extends StatelessWidget {
  static const routeName = '/unit-converter';

  const UnitConverter({Key? key}) : super(key: key);
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
                UnitBox(
                    icondata:
                        const UnitIcon(FontAwesomeIcons.globe, 'Currency'),
                    iconfunction: () {
                      Navigator.pushNamed(
                          context, ExchangeRateScreen.routeName);
                    }),
                UnitBox(
                    icondata: const UnitIcon(FontAwesomeIcons.ruler, 'Length'),
                    iconfunction: () {
                      log('Length');
                    }),
                UnitBox(
                    icondata:
                        const UnitIcon(FontAwesomeIcons.chartArea, 'Area'),
                    iconfunction: () {
                      log('Call');
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(
                    icondata:
                        const UnitIcon(FontAwesomeIcons.gaugeHigh, 'Speed'),
                    iconfunction: () {
                      log('Call');
                    }),
                UnitBox(
                    icondata: const UnitIcon(
                        FontAwesomeIcons.weightHanging, 'Weight'),
                    iconfunction: () {
                      log('Call');
                    }),
                UnitBox(
                    icondata: const UnitIcon(
                        FontAwesomeIcons.temperatureThreeQuarters,
                        'Temperature'),
                    iconfunction: () {
                      log('Call');
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(
                    icondata: const UnitIcon(FontAwesomeIcons.bolt, 'Power'),
                    iconfunction: () {
                      log('Call');
                    }),
                UnitBox(
                    icondata: const UnitIcon(
                        FontAwesomeIcons.gaugeSimple, 'Pressure'),
                    iconfunction: () {
                      log('Call');
                    }),
                UnitBox(
                    icondata: const UnitIcon(FontAwesomeIcons.cube, 'Volume'),
                    iconfunction: () {
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
