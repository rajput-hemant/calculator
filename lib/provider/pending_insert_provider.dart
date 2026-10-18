import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingInsertNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setValue(String? value) => state = value;
}

final pendingInsertProvider = NotifierProvider<PendingInsertNotifier, String?>(
  PendingInsertNotifier.new,
);
