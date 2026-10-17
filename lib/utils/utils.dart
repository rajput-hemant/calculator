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
  try {
    if (isFirstFieldSelected) {
      setTextKeepingCaret(
        secondFieldController,
        (double.parse(firstFieldController.text) *
                list[secondFieldIndex].rate! /
                list[firstFieldIndex].rate!)
            .toString(),
      );
    } else {
      setTextKeepingCaret(
        firstFieldController,
        (double.parse(secondFieldController.text) *
                list[firstFieldIndex].rate! /
                list[secondFieldIndex].rate!)
            .toString(),
      );
    }
  } catch (e) {
    // catch invalid double when field is empty
    setTextKeepingCaret(secondFieldController, "");
    setTextKeepingCaret(firstFieldController, "");
  }
}
