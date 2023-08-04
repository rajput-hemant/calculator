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
              _appVersion,
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
