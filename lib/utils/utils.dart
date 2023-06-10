export 'math_parser.dart';

import 'package:flutter/material.dart';

import '../models/models.dart';

void convertUnit(
  TextEditingController firstFieldController,
  TextEditingController secondFieldController,
  int firstFieldIndex,
  int secondFieldIndex,
  List<Unit> list,
  bool isFirstFieldSelected,
) {
  try {
    if (isFirstFieldSelected) {
      secondFieldController.text = (double.parse(firstFieldController.text) *
              list[secondFieldIndex].rate! /
              list[firstFieldIndex].rate!)
          .toString();
    } else {
      firstFieldController.text = (double.parse(secondFieldController.text) *
              list[firstFieldIndex].rate! /
              list[secondFieldIndex].rate!)
          .toString();
    }
  } catch (e) {
    // catch invalid double when field is empty
    secondFieldController.clear();
    firstFieldController.clear();
  }
}
