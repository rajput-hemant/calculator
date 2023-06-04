import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../routes/routes.dart';
import '../widgets/unit_item.dart';

class UnitConverterScreen extends StatelessWidget {
  const UnitConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Unit Converter"),
      // ),
      body: GridView.count(crossAxisCount: 3, children: [
        UnitItem(
          icon: FontAwesomeIcons.globe,
          label: "Currency",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.exchangeRateScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.ruler,
          label: "length",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.lengthConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.chartArea,
          label: "Area",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.areaConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.gaugeHigh,
          label: "Speed",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.speedConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.weightHanging,
          label: "Weight",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.weightConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.hardDrive,
          label: "Data",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.dataConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.bolt,
          label: "Power",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.powerConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.gaugeSimple,
          label: "Pressure",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.pressureConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.cube,
          label: "Volume",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.volumeConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.temperatureHalf,
          label: "Temperature",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.temperatureConversionScreen),
        ),
        UnitItem(
          icon: FontAwesomeIcons.clock,
          label: "Time",
          onPressed: () =>
              Navigator.pushNamed(context, Routes.timeConversionScreen),
        ),
      ]),
    );
  }
}
