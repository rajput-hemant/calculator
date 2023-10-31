import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../provider/preferences_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late String _appVersion = "0.2.0";

  @override
  void initState() {
    PackageInfo.fromPlatform().then((pkg) {
      setState(() {
        _appVersion = pkg.version;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(prefrencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: preferences.darkMode,
              onChanged: (_) {
                ref.read(prefrencesProvider.notifier).toggleDarkMode();
              },
            ),
            SwitchListTile(
              title: const Text("Tab View"),
              value: preferences.tabView,
              onChanged: (_) {
                ref.read(prefrencesProvider.notifier).toggleTabView();
              },
            ),
            ListTile(
              title: const Text("Version"),
              subtitle: Text(
                _appVersion,
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
