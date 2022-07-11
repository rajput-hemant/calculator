import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/calculator_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF060606)),
        primaryColor: const Color(0xFF060606),
      ),
      home: const CalculatorScreen(),
    );
  }
}
