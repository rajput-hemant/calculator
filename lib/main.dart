import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes/routes.dart';
import 'screens/screens.dart';
import 'theme/theme.dart';

Future<void> main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.dark,
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
              child: Image.asset("assets/images/app_icon.png"),
            ),
            title: const Text(
              'Calculator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/grid-light.png",
                  width: 24,
                  height: 24,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
            bottom: const TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  text: "Calculator",
                ),
                Tab(
                  text: "Exchange Rate",
                ),
                Tab(
                  text: "Unit Converter",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              // Column(
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: Padding(
              //         padding: EdgeInsets.all(8),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             TextField(
              //               // controller: textEditingController,
              //               keyboardType: TextInputType.none,
              //               textAlign: TextAlign.right,
              //               style: TextStyle(),
              //               decoration: InputDecoration(
              //                 border: InputBorder.none,
              //               ),
              //             ),
              //             Text("result"),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 3,
              //       child: Keypad(),
              //     )
              //   ],
              // ),
              CalculatorScreen(),
              ExchangeRateScreen(),
              UnitConverterScreen(),
            ],
          ),
        ),
      ),
      routes: {
        Routes.calculatorScreen: (context) => const CalculatorScreen(),
        Routes.unitConverterScreen: (context) => const UnitConverterScreen(),
        Routes.exchangeRateScreen: (context) => const ExchangeRateScreen(),
        Routes.areaConversionScreen: (context) => const AreaConversionScreen(),
        Routes.lengthConversionScreen: (context) =>
            const LengthConversionScreen(),
        Routes.weightConversionScreen: (context) =>
            const WeightConversionScreen(),
        Routes.volumeConversionScreen: (context) =>
            const VolumeConversionScreen(),
        // Routes.temperatureConversionScreen: (context) =>
        // const TemperatureConversionScreen(),
        Routes.timeConversionScreen: (context) => const TimeConversionScreen(),
        Routes.speedConversionScreen: (context) =>
            const SpeedConversionScreen(),
        Routes.dataConversionScreen: (context) => const DataConversionScreen(),
        Routes.pressureConversionScreen: (context) =>
            const PressureConversionScreen(),
        Routes.powerConversionScreen: (context) =>
            const PowerConversionScreen(),
      },
    );
  }
}
