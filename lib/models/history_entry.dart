import 'package:flutter/material.dart';

@immutable
class HistoryEntry {
  final String expression;
  final String result;
  final DateTime timestamp;

  const HistoryEntry({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'expression': expression,
    'result': result,
    'timestamp': timestamp.toIso8601String(),
  };

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    expression: json['expression'] as String,
    result: json['result'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );

  @override
  String toString() => 'HistoryEntry($expression = $result)';
}
