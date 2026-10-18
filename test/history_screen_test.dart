import 'dart:convert';

import 'package:calculator/provider/pending_insert_provider.dart';
import 'package:calculator/screens/history_screen.dart';
import 'package:calculator/theme/app_theme.dart';
import 'package:calculator/theme/tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> _entry(String expression, String result, DateTime at) => {
  'expression': expression,
  'result': result,
  'timestamp': at.toIso8601String(),
};

Future<ProviderContainer> _pump(WidgetTester tester) async {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: buildAppTheme(Tokens.seed, Brightness.light),
        home: const HistoryScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  testWidgets('shows empty state without a Clear action', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await _pump(tester);

    expect(find.text('No history yet'), findsOneWidget);
    expect(find.text('Clear'), findsNothing);
  });

  testWidgets('groups entries by day with display operators', (tester) async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    SharedPreferences.setMockInitialValues({
      'calculator_history': [
        jsonEncode(_entry('12x7+36.5', '120.5', now)),
        jsonEncode(_entry('1240/8', '155', now)),
        jsonEncode(_entry('2^8-56', '200', yesterday)),
      ],
    });
    await _pump(tester);

    expect(find.text('History'), findsOneWidget);
    expect(find.text('TODAY'), findsOneWidget);
    expect(find.text('YESTERDAY'), findsOneWidget);
    expect(find.text('12×7+36.5'), findsOneWidget);
    expect(find.text('1240÷8'), findsOneWidget);
    expect(find.text('2^8−56'), findsOneWidget);
    expect(find.text('120.5'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
    expect(find.text('Tap a result to reuse it'), findsOneWidget);
  });

  testWidgets('tapping a row queues its result for insertion', (tester) async {
    SharedPreferences.setMockInitialValues({
      'calculator_history': [
        jsonEncode(_entry('1240/8', '155', DateTime.now())),
      ],
    });
    final container = await _pump(tester);

    await tester.tap(find.text('155'));
    await tester.pumpAndSettle();

    expect(container.read(pendingInsertProvider), '155');
  });
}
