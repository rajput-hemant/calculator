import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final bool darkMode;
  final bool tabView;

  Preferences({
    this.darkMode = true,
    this.tabView = true,
  });
}

class PreferencesProvider extends StateNotifier<Preferences> {
  PreferencesProvider() : super(Preferences()) {
    _loadStateFromSharedPrefs();
  }

  Future<void> _loadStateFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool darkMode = prefs.getBool('darkMode') ?? true;
    bool tabView = prefs.getBool('tabView') ?? true;

    state = Preferences(
      darkMode: darkMode,
      tabView: tabView,
    );
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
}

final prefrencesProvider =
    StateNotifierProvider<PreferencesProvider, Preferences>(
  (ref) => PreferencesProvider(),
);
