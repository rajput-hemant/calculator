import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/unit_box.dart';
import '../widgets/unit_icon.dart';

class UnitConverter extends StatelessWidget {
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
                  print('Call');
                }),
                UnitBox(const UnitIcon(FontAwesomeIcons.ruler, 'Length'), () {
                  Navigator.pushNamed(context, 'Length');
                }),
                UnitBox(const UnitIcon(FontAwesomeIcons.chartArea, 'Area'), () {
                  print('Call');
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(const UnitIcon(FontAwesomeIcons.gaugeHigh, 'Speed'),
                    () {
                  print('Call');
                }),
                UnitBox(
                    const UnitIcon(FontAwesomeIcons.weightHanging, 'Weight'),
                    () {
                  print('Call');
                }),
                UnitBox(
                    const UnitIcon(FontAwesomeIcons.temperatureThreeQuarters,
                        'Temperature'), () {
                  print('Call');
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(const UnitIcon(FontAwesomeIcons.bolt, 'Power'), () {
                  print('Call');
                }),
                UnitBox(
                    const UnitIcon(FontAwesomeIcons.gaugeSimple, 'Pressure'),
                    () {
                  print('Call');
                }),
                UnitBox(const UnitIcon(FontAwesomeIcons.cube, 'Volume'), () {
                  print('Call');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
