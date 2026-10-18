import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/text_editing.dart';
import 'controls.dart';
import 'currency_badge.dart';
import 'glass.dart';
import 'grouped_list.dart';

typedef _Row = ({int index, Unit unit});

/// Searchable picker body for the floating unit sheet opened from a field
/// card. Pops with the ORIGINAL index into [widget.list], never the
/// display-sorted position.
class SelectUnitSheet extends StatefulWidget {
  const SelectUnitSheet({
    super.key,
    required this.title,
    required this.list,
    required this.selectedUnitIndex,
    this.isCurrency = false,
  });

  final String title;
  final List<Unit> list;
  final int selectedUnitIndex;
  final bool isCurrency;

  @override
  State<SelectUnitSheet> createState() => _SelectUnitSheetState();
}

class _SelectUnitSheetState extends State<SelectUnitSheet> {
  final TextEditingController _searchController = textEditingController();
  late List<_Row> _rows;

  @override
  void initState() {
    super.initState();
    _rows = _rowsFor('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filtered and name-sorted for display. Each row keeps its true index
  /// into [widget.list], so a tap pops the saved index, not the row position.
  List<_Row> _rowsFor(String query) {
    final q = query.toLowerCase();
    final rows = <_Row>[
      for (var i = 0; i < widget.list.length; i++)
        if (_matches(widget.list[i], q)) (index: i, unit: widget.list[i]),
    ];
    rows.sort(
      (a, b) => a.unit.name.toLowerCase().compareTo(b.unit.name.toLowerCase()),
    );
    return rows;
  }

  static bool _matches(Unit unit, String q) =>
      unit.name.toLowerCase().contains(q) ||
      unit.id.toLowerCase().contains(q) ||
      (unit.symbol ?? '').toLowerCase().contains(q);

  void _filterList(String query) => setState(() => _rows = _rowsFor(query));

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final countText = widget.isCurrency
        ? '${widget.list.length} currencies'
        : '${widget.list.length} units';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Gaps.sm),
          child: Container(
            width: 36,
            height: 5,
            decoration: BoxDecoration(
              color: p.label3,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(Gaps.xxl, Gaps.sm, Gaps.sm, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.title.copyWith(color: p.label),
                ),
              ),
              GlassAction(
                icon: AppIcons.close,
                tooltip: 'Close',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Gaps.lg,
            Gaps.md,
            Gaps.lg,
            Gaps.md,
          ),
          child: SearchField(
            hint: 'Search $countText',
            controller: _searchController,
            onChanged: _filterList,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Gaps.lg),
            child: Material(
              color: p.cell,
              shape: AppShapes.of(context).border(Radii.card),
              clipBehavior: Clip.antiAlias,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: Gaps.lg),
                itemCount: _rows.length,
                itemBuilder: (context, i) {
                  final (:index, :unit) = _rows[i];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i > 0)
                        Padding(
                          // Separators start where the text does.
                          padding: EdgeInsets.only(
                            left: widget.isCurrency ? 62 : 18,
                          ),
                          child: const Divider(),
                        ),
                      GroupCell(
                        title: unit.name,
                        leading: widget.isCurrency
                            ? CurrencyBadge(code: unit.id)
                            : null,
                        trailing: Text(
                          widget.isCurrency
                              ? (unit.symbol ?? unit.id)
                              : unit.id,
                        ),
                        selected: index == widget.selectedUnitIndex,
                        onTap: () => Navigator.pop(context, index),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
