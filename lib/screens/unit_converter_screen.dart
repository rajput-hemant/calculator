import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'area_conversion_screen.dart';
import 'data_conversion_screen.dart';
import 'exchange_rate_screen.dart';
import 'length_conversion_screen.dart';
import 'power_conversion_screen.dart';
import 'pressure_conversion_screen.dart';
import 'speed_conversion_screen.dart';
import 'volume_conversion_screen.dart';
import 'weigth_conversion_screen.dart';
import '../widgets/unit_box.dart';
import '../widgets/unit_icon.dart';

class UnitConverterScreen extends StatelessWidget {
  static const routeName = '/unit-converter';

  const UnitConverterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Unit converter",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.globe, textData: 'Currency'),
                  iconfunction: () => Navigator.pushNamed(
                      context, ExchangeRateScreen.routeName),
                ),
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.ruler, textData: 'Length'),
                  iconfunction: () => Navigator.pushNamed(
                      context, LengthConversionScreen.routeName),
                ),
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.chartArea, textData: 'Area'),
                  iconfunction: () => Navigator.pushNamed(
                      context, AreaConversionScreen.routeName),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.gaugeHigh, textData: 'Speed'),
                  iconfunction: () => Navigator.pushNamed(
                      context, SpeedConversionScreen.routeName),
                ),
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.weightHanging,
                      textData: 'Weight'),
                  iconfunction: () => Navigator.pushNamed(
                      context, WeightConversionScreen.routeName),
                ),
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.hardDrive, textData: 'Data'),
                  iconfunction: () => Navigator.pushNamed(
                      context, DataConversionScreen.routeName),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.bolt, textData: 'Power'),
                  iconfunction: () => Navigator.pushNamed(
                      context, PowerConversionScreen.routeName),
                ),
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.gaugeSimple,
                      textData: 'Pressure'),
                  iconfunction: () => Navigator.pushNamed(
                      context, PressureConversionScreen.routeName),
                ),
                UnitBox(
                  icondata: const UnitIcon(
                      iconName: FontAwesomeIcons.cube, textData: 'Volume'),
                  iconfunction: () => Navigator.pushNamed(
                      context, VolumeConversionScreen.routeName),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
