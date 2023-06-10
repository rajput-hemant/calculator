import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/preferences_provider.dart';
import '../screens/screens.dart';
import 'main_appbar.dart';

class TabViewController extends ConsumerWidget {
  const TabViewController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTabView = ref.watch(prefrencesProvider).tabView;

    return isTabView
        ? const DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              appBar: MainAppBar(),
              body: TabBarView(
                children: [
                  CalculatorScreen(),
                  ExchangeRateScreen(),
                  UnitConverterScreen(),
                ],
              ),
            ),
          )
        : const CalculatorScreen();
  }
}
