import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/history_entry.dart';

class HistoryNotifier extends Notifier<List<HistoryEntry>> {
  static const String _key = 'calculator_history';
  static const int _cap = 100;
  Future<void>? _loadFuture;

  @override
  List<HistoryEntry> build() {
    _loadFuture = load();
    return [];
  }

  /// Load history from SharedPreferences and update state.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key);
    if (list != null) {
      final loaded = <HistoryEntry>[];
      for (final raw in list) {
        try {
          final decoded = jsonDecode(raw);
          if (decoded is Map<String, dynamic>) {
            loaded.add(HistoryEntry.fromJson(decoded));
            continue;
          }
        } catch (_) {}
        try {
          final expression = _extract(raw, 'expression');
          final resultStr = _extract(raw, 'result');
          final tsStr = _extract(raw, 'timestamp');
          loaded.add(
            HistoryEntry(
              expression: expression,
              result: resultStr,
              timestamp: DateTime.parse(tsStr),
            ),
          );
        } catch (_) {
          // Ignore malformed entries
        }
      }
      state = loaded;
    } else {
      state = [];
    }
  }

  static String _extract(String raw, String field) {
    final idx = raw.indexOf('"$field":"');
    if (idx == -1) return '';
    final start = idx + ('"$field":"').length;
    final end = raw.indexOf('"', start);
    return raw.substring(start, end);
  }

  Future<void> add(HistoryEntry entry) async {
    if (_loadFuture != null) {
      await _loadFuture;
    }
    final updated = [entry, ...state];
    state = updated.length > _cap ? updated.sublist(0, _cap) : updated;
    await _persist();
  }

  Future<void> clearAll() async {
    if (_loadFuture != null) {
      await _loadFuture;
    }
    state = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _key,
      state.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}

final historyProvider = NotifierProvider<HistoryNotifier, List<HistoryEntry>>(
  HistoryNotifier.new,
);
