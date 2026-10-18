import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/history_entry.dart';
import '../provider/history_provider.dart';
import '../provider/pending_insert_provider.dart';
import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/glyphs.dart';
import '../widgets/glass.dart';
import '../widgets/grouped_list.dart';
import '../widgets/readable_width.dart';

sealed class _Item {
  const _Item();
}

final class _Title extends _Item {
  const _Title();
}

final class _Header extends _Item {
  const _Header(this.label);

  final String label;
}

final class _Row extends _Item {
  const _Row(this.entry, {required this.first, required this.last});

  final HistoryEntry entry;
  final bool first;
  final bool last;
}

final class _Footer extends _Item {
  const _Footer();
}

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  List<HistoryEntry>? _itemsFor;
  List<_Item> _items = const [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final entries = ref.watch(historyProvider);
    final top = Tokens.topBarInset(context);

    return Scaffold(
      backgroundColor: p.grouped,
      extendBodyBehindAppBar: true,
      appBar: GlassTopBar(
        trailing: entries.isEmpty
            ? null
            : GlassTextAction(
                label: 'Clear',
                onPressed: () => _confirmClear(context),
              ),
      ),
      body: ReadableWidth(
        child: entries.isEmpty
            ? _emptyState(context, top)
            : _list(context, _itemsOf(entries), top),
      ),
    );
  }

  Widget _emptyState(BuildContext context, double top) {
    final p = Palette.of(context);
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Column(
        children: [
          const LargeTitle('History'),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(AppIcons.history, size: 48, color: p.label3),
                  const SizedBox(height: 16),
                  Text(
                    'No history yet',
                    style: AppText.title.copyWith(color: p.label),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Your calculations will appear here, tappable to reuse.',
                    textAlign: TextAlign.center,
                    style: AppText.callout.copyWith(color: p.label2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_Item> _itemsOf(List<HistoryEntry> entries) {
    if (!identical(entries, _itemsFor)) {
      _itemsFor = entries;
      _items = _flatten(entries);
    }
    return _items;
  }

  List<_Item> _flatten(List<HistoryEntry> entries) {
    final now = DateTime.now();
    final days = <DateTime, List<HistoryEntry>>{};
    for (final entry in entries) {
      final t = entry.timestamp;
      days.putIfAbsent(DateTime(t.year, t.month, t.day), () => []).add(entry);
    }
    return [
      const _Title(),
      for (final day in days.entries) ...[
        _Header(_dayLabel(day.key, now)),
        for (var i = 0; i < day.value.length; i++)
          _Row(day.value[i], first: i == 0, last: i == day.value.length - 1),
      ],
      const _Footer(),
    ];
  }

  Widget _list(BuildContext context, List<_Item> items, double top) {
    return ListView.builder(
      padding: EdgeInsets.only(
        top: top,
        bottom: MediaQuery.paddingOf(context).bottom + 24,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => switch (items[i]) {
        _Title() => const LargeTitle('History'),
        _Header(:final label) => SectionHeader(label),
        _Row(:final entry, :final first, :final last) => _row(
          context,
          entry,
          first: first,
          last: last,
        ),
        _Footer() => const SectionFooter('Tap a result to reuse it'),
      },
    );
  }

  Widget _row(
    BuildContext context,
    HistoryEntry entry, {
    required bool first,
    required bool last,
  }) {
    final p = Palette.of(context);
    const corner = Radius.circular(Radii.card);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gaps.lg),
      child: Material(
        color: p.cell,
        shape: AppShapes.of(context).corners(
          BorderRadius.vertical(
            top: first ? corner : Radius.zero,
            bottom: last ? corner : Radius.zero,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GroupCell(
              title: displayGlyphs(entry.expression),
              subtitle: _time(context, entry.timestamp),
              trailing: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.45,
                ),
                child: Text(
                  entry.result,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Numerals.result.copyWith(color: p.label),
                ),
              ),
              onTap: () => _insertResult(context, entry.result),
            ),
            if (!last) const Divider(indent: 18),
          ],
        ),
      ),
    );
  }

  String _time(BuildContext context, DateTime t) =>
      MaterialLocalizations.of(context).formatTimeOfDay(
        TimeOfDay.fromDateTime(t),
        alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
      );

  String _dayLabel(DateTime day, DateTime now) {
    if (day == DateTime(now.year, now.month, now.day)) return 'Today';
    if (day == DateTime(now.year, now.month, now.day - 1)) return 'Yesterday';
    return DateFormat('d MMM').format(day);
  }

  Future<void> _confirmClear(BuildContext context) async {
    final clear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear history?'),
        content: const Text('All saved calculations will be removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (clear ?? false) ref.read(historyProvider.notifier).clearAll();
  }

  void _insertResult(BuildContext context, String result) {
    ref.read(pendingInsertProvider.notifier).setValue(result);
    // Opened as its own route from the app bar, so the pop always returns to
    // the calculator underneath.
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
