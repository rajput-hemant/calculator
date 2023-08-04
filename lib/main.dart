import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/preferences_provider.dart';
import 'routes/routes.dart';
import 'screens/screens.dart';
import 'theme/theme.dart';
import 'widgets/tab_controller.dart';

Future<void> main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const ProviderScope(
      child: Calculator(),
    ),
  );
}

class Calculator extends ConsumerWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(prefrencesProvider).darkMode;

    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
        Routes.frequencyConversionScreen: (context) =>
            const FrequencyConversionScreen(),
        Routes.fuelEconomyConversionScreen: (context) =>
            const FuelEconomyConversionScreen(),
        Routes.planeAngleConversionScreen: (context) =>
            const PlaneAngleConversionScreen(),
        Routes.dataConversionScreen: (context) => const DataConversionScreen(),
        Routes.pressureConversionScreen: (context) =>
            const PressureConversionScreen(),
        Routes.powerConversionScreen: (context) =>
            const PowerConversionScreen(),
        Routes.energyConversionScreen: (context) =>
            const EnergyConversionScreen(),
        Routes.settingsScreen: (context) => const SettingsScreen(),
        Routes.aboutScreen: (context) => const AboutScreen(),
      },
    );
  }
}
