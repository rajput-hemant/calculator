import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/models.dart';
import 'provider/preferences_provider.dart';
import 'routes/routes.dart';
import 'screens/screens.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: Calculator()));
}

class Calculator extends ConsumerWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only these settings affect the app shell; watching the whole
    // preferences object would rebuild it on every toggle.
    final seedColor = Color(
      ref.watch(prefrencesProvider.select((p) => p.accentColor)),
    );
    final themeMode = ref.watch(prefrencesProvider.select((p) => p.themeMode));
    final shape = ref.watch(prefrencesProvider.select((p) => p.buttonShape));

    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(seedColor, Brightness.light, shape),
      darkTheme: buildAppTheme(seedColor, Brightness.dark, shape),
      themeMode: themeMode,
      builder: (context, child) => BackdropGroup(child: child!),
      home: const CalculatorScreen(),
      routes: {
        Routes.calculatorScreen: (context) => const CalculatorScreen(),
        Routes.unitConverterScreen: (context) => const UnitConverterScreen(),
        Routes.exchangeRateScreen: (context) => const ExchangeRateScreen(),
        Routes.conversionScreen: (context) => ConversionScreen(
          category:
              ModalRoute.of(context)!.settings.arguments as Units? ??
              Units.length,
        ),
        Routes.settingsScreen: (context) => const SettingsScreen(),
        Routes.aboutScreen: (context) => const AboutScreen(),
        Routes.historyScreen: (context) => const HistoryScreen(),
      },
    );
  }
}
