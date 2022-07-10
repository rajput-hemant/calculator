import 'package:calculator/screens/calculator_ui.dart';
import 'package:calculator/screens/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: calculator_ui(),
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Color(0xFF060606)),
      ),
      routes: {
        'unit_converter': ((context) => UnitConverter()),
      },
    );
  }
}
