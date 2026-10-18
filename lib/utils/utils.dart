export 'math_parser.dart';

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'text_editing.dart';

void convertUnit(
  TextEditingController firstFieldController,
  TextEditingController secondFieldController,
  int firstFieldIndex,
  int secondFieldIndex,
  List<Unit> list,
  bool isFirstFieldSelected,
) {
  final String inputText = isFirstFieldSelected
      ? firstFieldController.text
      : secondFieldController.text;
  final TextEditingController outputController = isFirstFieldSelected
      ? secondFieldController
      : firstFieldController;

  // A partial or empty input cannot be converted. Leave the field the user is
  // not editing alone instead of silently wiping it.
  final double? input = double.tryParse(inputText);
  if (input == null) return;

  String output;
  if (firstFieldIndex == secondFieldIndex) {
    // Same unit in, same value out.
    output = inputText;
  } else if (list is List<Temperature>) {
    // Temperatures have no linear rate: pivot through Celsius, which covers
    // every pairing (the old if-chain silently fell through wrong for some).
    output = _fromCelsius(
      _toCelsius(input, firstFieldIndex),
      secondFieldIndex,
    ).toStringAsFixed(6);
  } else {
    output = (input * list[secondFieldIndex].rate! / list[firstFieldIndex].rate!)
        .toString();
  }

  setTextKeepingCaret(outputController, output);
}

double _toCelsius(double value, int index) => switch (index) {
      0 => value, // Celsius
      1 => (value - 32) * 5 / 9, // Fahrenheit
      2 => value - 273.15, // Kelvin
      3 => (value - 491.67) * 5 / 9, // Rankine
      4 => value * 5 / 4, // Réaumur
      _ => (value - 7.5) * 40 / 21, // Rømer
    };

double _fromCelsius(double value, int index) => switch (index) {
      0 => value,
      1 => value * 9 / 5 + 32,
      2 => value + 273.15,
      3 => (value + 273.15) * 9 / 5,
      4 => value * 4 / 5,
      _ => value * 21 / 40 + 7.5,
    };
