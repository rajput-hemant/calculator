import 'package:calculator/screens/area_conversion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/about.dart';
import 'screens/calculator_screen.dart';
import 'screens/exchange_rate_screen.dart';
import 'screens/length_conversion_screen.dart';
import 'screens/settings.dart';
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
        UnitConverter.routeName: (context) => const UnitConverter(),
        Settings.routeName: (context) => const Settings(),
        About.routename: ((context) => const About()),
      },
    );
  }
}
