import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes/routes.dart';
import 'screens/screens.dart';
import 'screens/settings_screen.dart';
import 'theme/theme.dart';
import 'widgets/tab_controller.dart';

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
      home: const TabViewController(),
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
        Routes.temperatureConversionScreen: (context) =>
            const TemperatureConversionScreen(),
        Routes.timeConversionScreen: (context) => const TimeConversionScreen(),
        Routes.speedConversionScreen: (context) =>
            const SpeedConversionScreen(),
        Routes.dataConversionScreen: (context) => const DataConversionScreen(),
        Routes.pressureConversionScreen: (context) =>
            const PressureConversionScreen(),
        Routes.powerConversionScreen: (context) =>
            const PowerConversionScreen(),
        Routes.settingsScreen: (context) => const SettingsScreen(),
      },
    );
  }
}
