import 'package:flutter_riverpod/flutter_riverpod.dart';

class Preferences {
  final bool darkMode;
  final bool tabView;

  Preferences({
    this.darkMode = true,
    this.tabView = true,
  });
}

class PreferencesProvider extends StateNotifier<Preferences> {
  PreferencesProvider() : super(Preferences());

  void toggleDarkMode() {
    state = Preferences(darkMode: !state.darkMode, tabView: state.tabView);
  }

  void toggleTabView() {
    state = Preferences(darkMode: state.darkMode, tabView: !state.tabView);
  }
}

final prefrencesProvider =
    StateNotifierProvider<PreferencesProvider, Preferences>(
  (ref) => PreferencesProvider(),
);
