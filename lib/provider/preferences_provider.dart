import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class Preferences {
  final bool darkMode;
  final bool tabView;
  final Map<Units, List<int>> unitIndexes;

  Preferences({
    this.darkMode = true,
    this.tabView = true,
    this.unitIndexes = const {
      Units.area: [8, 7],
      Units.currency: [15, 31],
      Units.data: [3, 7],
      Units.energy: [5, 6],
      Units.frequency: [0, 1],
      Units.fuel: [0, 3],
      Units.length: [5, 0],
      Units.planeAngle: [0, 1],
      Units.power: [9, 6],
      Units.pressure: [0, 7],
      Units.temperature: [0, 1],
      Units.speed: [1, 2],
      Units.time: [8, 7],
      Units.volume: [9, 1],
      Units.weight: [3, 2],
    },
  });
}

class PreferencesProvider extends StateNotifier<Preferences> {
  PreferencesProvider() : super(Preferences()) {
    _loadStateFromSharedPrefs();
  }

  Future<void> _loadStateFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool darkMode = prefs.getBool('darkMode') ?? state.darkMode;
    bool tabView = prefs.getBool('tabView') ?? state.tabView;

    final unitIndexes = <Units, List<int>>{};
    for (final key in state.unitIndexes.keys) {
      final indexes =
          prefs.getStringList(key.toString()) ?? state.unitIndexes[key];
      unitIndexes[key] =
          indexes!.map((index) => int.parse(index.toString())).toList();
    }

    state = Preferences(
        darkMode: darkMode, tabView: tabView, unitIndexes: unitIndexes);
  }

  void toggleDarkMode() {
    state = Preferences(darkMode: !state.darkMode, tabView: state.tabView);

    // save dark mode to shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('darkMode', state.darkMode);
    });
  }

  void toggleTabView() {
    state = Preferences(darkMode: state.darkMode, tabView: !state.tabView);

    // save tab view to shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('tabView', state.tabView);
    });
  }

  void setUnitIndexes(Units key, List<int> indexes) {
    state.unitIndexes[key] = indexes;

    // save unit indexes to shared preferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(
          key.toString(), indexes.map((index) => index.toString()).toList());
    });
  }
}

final prefrencesProvider =
    StateNotifierProvider<PreferencesProvider, Preferences>(
  (ref) => PreferencesProvider(),
);
