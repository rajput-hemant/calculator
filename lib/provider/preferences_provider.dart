import 'dart:async' show unawaited;

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../theme/tokens.dart';

/// `round` = circular keys (pills in compact keypads), the Paper default.
enum ButtonShape { round, rounded, squircle }

enum ButtonElevation { flat, raised }

class Preferences {
  const Preferences({
    this.themeMode = ThemeMode.system,
    this.accentColor = Tokens.seedValue,
    this.buttonShape = ButtonShape.round,
    this.buttonElevation = ButtonElevation.raised,
    this.hapticsEnabled = true,
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
      Units.speed: [1, 2],
      Units.time: [8, 7],
      Units.volume: [9, 1],
      Units.weight: [3, 2],
    },
  });

  final ThemeMode themeMode;
  final int accentColor;
  final ButtonShape buttonShape;
  final ButtonElevation buttonElevation;
  final bool hapticsEnabled;
  final Map<Units, List<int>> unitIndexes;

  Preferences copyWith({
    ThemeMode? themeMode,
    int? accentColor,
    ButtonShape? buttonShape,
    ButtonElevation? buttonElevation,
    bool? hapticsEnabled,
    Map<Units, List<int>>? unitIndexes,
  }) {
    return Preferences(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      buttonShape: buttonShape ?? this.buttonShape,
      buttonElevation: buttonElevation ?? this.buttonElevation,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      unitIndexes: unitIndexes ?? this.unitIndexes,
    );
  }
}

class PreferencesNotifier extends Notifier<Preferences> {
  @override
  Preferences build() {
    // Start async loading but return defaults immediately so the UI
    // can render synchronously with valid data.
    unawaited(_loadStateFromSharedPrefs());
    return const Preferences();
  }

  Future<void> _loadStateFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Unknown or missing names (including the retired 'darkMode' bool era)
    // fall back to following the system.
    final themeMode =
        ThemeMode.values.asNameMap()[prefs.getString('themeMode')] ??
        ThemeMode.system;

    final accentColor = prefs.getInt('accentColor') ?? Tokens.seedValue;
    final storedShape = prefs.getString('buttonShape');
    // 'square' was renamed to squircle; keep existing users on a squarish key.
    final buttonShape = storedShape == 'square'
        ? ButtonShape.squircle
        : ButtonShape.values.asNameMap()[storedShape] ?? ButtonShape.round;
    final buttonElevation =
        ButtonElevation.values.asNameMap()[prefs.getString(
          'buttonElevation',
        )] ??
        ButtonElevation.raised;
    final hapticsEnabled = prefs.getBool('hapticsEnabled') ?? true;

    // Use default Preferences to get the unit keys, since `state` is not
    // available during the initial build().
    final defaultPrefs = const Preferences();
    final unitIndexes = <Units, List<int>>{};
    for (final key in defaultPrefs.unitIndexes.keys) {
      final stored = prefs.getStringList(key.toString());
      unitIndexes[key] =
          stored?.map(int.parse).toList() ?? defaultPrefs.unitIndexes[key]!;
    }

    // Riverpod Notifier doesn't have a mounted getter; instead we catch
    // any state update after disposal by checking if we can still access
    // the provider container. This is a pragmatic approach for tests.
    try {
      state = state.copyWith(
        themeMode: themeMode,
        accentColor: accentColor,
        buttonShape: buttonShape,
        buttonElevation: buttonElevation,
        hapticsEnabled: hapticsEnabled,
        unitIndexes: unitIndexes,
      );
    } catch (_) {
      // Notifier disposed; ignore the update.
    }
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('themeMode', mode.name);
    });
  }

  void setAccentColor(int color) {
    state = state.copyWith(accentColor: color);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('accentColor', color);
    });
  }

  void setButtonShape(ButtonShape shape) {
    state = state.copyWith(buttonShape: shape);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('buttonShape', shape.name);
    });
  }

  void setButtonElevation(ButtonElevation elevation) {
    state = state.copyWith(buttonElevation: elevation);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('buttonElevation', elevation.name);
    });
  }

  void setHapticsEnabled(bool enabled) {
    state = state.copyWith(hapticsEnabled: enabled);

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('hapticsEnabled', enabled);
    });
  }

  void setUnitIndexes(Units key, List<int> indexes) {
    // A fresh map: assigning into state.unitIndexes leaves the state object
    // identical, and Riverpod then never notifies anyone.
    state = state.copyWith(unitIndexes: {...state.unitIndexes, key: indexes});

    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(
        key.toString(),
        indexes.map((index) => index.toString()).toList(),
      );
    });
  }
}

final prefrencesProvider = NotifierProvider<PreferencesNotifier, Preferences>(
  PreferencesNotifier.new,
);
