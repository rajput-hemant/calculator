import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/preferences_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(prefrencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: preferences.darkMode,
            onChanged: (_) {
              ref.read(prefrencesProvider.notifier).toggleDarkMode();
            },
            title: const Text("Dark Mode"),
          ),
          SwitchListTile(
            value: preferences.tabView,
            onChanged: (_) {
              ref.read(prefrencesProvider.notifier).toggleTabView();
            },
            title: const Text("Tab View"),
          ),
          ListTile(
            title: const Text("Version"),
            subtitle: Text(
              "0.2.0",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
    );
  }
}
