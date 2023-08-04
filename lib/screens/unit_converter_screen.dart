import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/preferences_provider.dart';
import '../routes/routes.dart';
import '../widgets/unit_item.dart';

class UnitConverterScreen extends ConsumerWidget {
  const UnitConverterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTabView = ref.watch(prefrencesProvider).tabView;

    return Scaffold(
      appBar: isTabView
          ? null
          : AppBar(
              title: const Text(
                "Unit Converter",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
      body: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(10),
          children: [
            if (!isTabView)
              UnitItem(
                icon: FontAwesomeIcons.globe,
                label: "Currency",
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.exchangeRateScreen),
              ),
            UnitItem(
              icon: FontAwesomeIcons.ruler,
              label: "Length",
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
              icon: FontAwesomeIcons.fire,
              label: "Energy",
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.energyConversionScreen),
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
              onPressed: () => Navigator.pushNamed(
                  context, Routes.temperatureConversionScreen),
            ),
            UnitItem(
              icon: FontAwesomeIcons.clock,
              label: "Time",
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.timeConversionScreen),
            ),
            UnitItem(
              icon: FontAwesomeIcons.chartSimple,
              label: "Frequency",
              onPressed: () => Navigator.pushNamed(
                  context, Routes.frequencyConversionScreen),
            ),
            UnitItem(
              icon: FontAwesomeIcons.gasPump,
              label: "Fuel Economy",
              onPressed: () => Navigator.pushNamed(
                  context, Routes.fuelEconomyConversionScreen),
            ),
          ]),
    );
  }
}
