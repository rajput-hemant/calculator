import 'package:calculator/screens/area_conversion_screen.dart';
import 'package:calculator/screens/power_conversion_screen.dart';
import 'package:calculator/screens/pressure_conversion_screen.dart';
import 'package:calculator/screens/speed_conversion_screen.dart';
import 'package:calculator/screens/temperature_conversion_screen.dart';
import 'package:calculator/screens/volume_conversion_screen.dart';
import 'package:calculator/screens/weigth_conversion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/about_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/exchange_rate_screen.dart';
import 'screens/length_conversion_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/unit_converter.dart';

void main() {
  WidgetsFlutterBinding();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF060606)),
        primaryColor: const Color(0xFF060606),
      ),
      home: const CalculatorScreen(),
      routes: {
        ExchangeRateScreen.routeName: (context) => const ExchangeRateScreen(),
        LengthConversionScreen.routeName: (context) =>
            const LengthConversionScreen(),
        AreaConversionScreen.routeName: (context) =>
            const AreaConversionScreen(),
        SpeedConversionScreen.routeName: (context) =>
            const SpeedConversionScreen(),
        WeightConversionScreen.routeName: (context) =>
            const WeightConversionScreen(),
        TemperatureConversionScreen.routeName: (context) =>
            const TemperatureConversionScreen(),
        PowerConversionScreen.routeName: (context) =>
            const PowerConversionScreen(),
        PressureConversionScreen.routeName: (context) =>
            const PressureConversionScreen(),
        VolumeConversionScreen.routeName: (context) =>
            const VolumeConversionScreen(),
        UnitConverter.routeName: (context) => const UnitConverter(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        AboutScreen.routename: ((context) => const AboutScreen()),
      },
    );
  }
}
