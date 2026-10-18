import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../provider/preferences_provider.dart';
import '../theme/app_icons.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/money_converter.dart';
import '../utils/text_editing.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';
import '../widgets/readable_width.dart';
import '../widgets/top_bar.dart';

/// "2:22 PM" for today, "Oct 17" otherwise.
String _updatedText(DateTime time) {
  final now = DateTime.now();
  final isToday =
      time.year == now.year && time.month == now.month && time.day == now.day;
  return isToday
      ? DateFormat.jm().format(time)
      : DateFormat.MMMd().format(time);
}

class ExchangeRateScreen extends ConsumerStatefulWidget {
  const ExchangeRateScreen({super.key});

  @override
  ConsumerState<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends ConsumerState<ExchangeRateScreen> {
  Map<String, dynamic> _rates = {"data": <String, double>{}};
  String _lastUpdated = "-";
  bool _isRefreshing = false;
  bool _failed = false;

  final TextEditingController _firstFieldController = textEditingController(
    "1",
  );
  final TextEditingController _secondFieldController = textEditingController(
    "0.01",
  );

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  void convert(int firstFieldIndex, int secondFieldIndex) {
    String from = Currency.currenciesList[firstFieldIndex].id;
    String to = Currency.currenciesList[secondFieldIndex].id;

    final data = _rates["data"] as Map;
    final fromRate = data[from];
    final toRate = data[to];
    // A missing rate only happens when the fallback provider was unreachable,
    // so leave the fields untouched instead of clearing the user's input.
    if (fromRate is! num || toRate is! num) return;

    final amount = double.tryParse(
      _isFirstFieldSelected
          ? _firstFieldController.text
          : _secondFieldController.text,
    );
    if (amount == null) return;

    final rate = _isFirstFieldSelected ? toRate / fromRate : fromRate / toRate;
    if (!rate.isFinite) return;

    final newText = (amount * rate).toStringAsFixed(2);
    setTextKeepingCaret(
      _isFirstFieldSelected ? _secondFieldController : _firstFieldController,
      newText,
    );
  }

  void changeSelectedIndex(int index) {
    final [firstFieldIndex, secondFieldIndex] = ref
        .read(preferencesProvider)
        .unitIndexes[Units.currency]!;

    ref
        .read(preferencesProvider.notifier)
        .setUnitIndexes(
          Units.currency,
          _isFirstLabelSelected
              ? [index, secondFieldIndex]
              : [firstFieldIndex, index],
        );

    _isFirstFieldSelected
        ? convert(firstFieldIndex, index)
        : convert(index, secondFieldIndex);
  }

  Future<void> _load({bool refreshing = false}) async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    try {
      final rates = await MoneyConverter.fetchRates(refreshing: refreshing);
      if (!mounted) return;
      final fetchedAt = rates["fetchedAt"] as int?;
      final date = rates["date"] as String?;
      final updated = fetchedAt != null
          ? _updatedText(DateTime.fromMillisecondsSinceEpoch(fetchedAt))
          : date != null
          ? DateFormat.MMMd().format(DateTime.parse(date))
          : "-";
      final [firstFieldIndex, secondFieldIndex] = ref
          .read(preferencesProvider)
          .unitIndexes[Units.currency]!;
      setState(() {
        _rates = rates;
        _lastUpdated = updated;
        _failed = false;
      });
      convert(firstFieldIndex, secondFieldIndex);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  void _swap() {
    final [firstFieldIndex, secondFieldIndex] = ref
        .read(preferencesProvider)
        .unitIndexes[Units.currency]!;

    final firstValue = _firstFieldController.text;
    setTextKeepingCaret(_firstFieldController, _secondFieldController.text);
    setTextKeepingCaret(_secondFieldController, firstValue);

    setState(() {
      _isFirstFieldSelected = !_isFirstFieldSelected;
      _isFirstLabelSelected = !_isFirstLabelSelected;
    });
    ref.read(preferencesProvider.notifier).setUnitIndexes(Units.currency, [
      secondFieldIndex,
      firstFieldIndex,
    ]);
    convert(secondFieldIndex, firstFieldIndex);
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final prefs = ref.watch(preferencesProvider);
    final [firstFieldIndex, secondFieldIndex] =
        prefs.unitIndexes[Units.currency]!;

    final fromCurrency = Currency.currenciesList[firstFieldIndex];
    final toCurrency = Currency.currenciesList[secondFieldIndex];
    final data = _rates["data"] as Map?;
    final fromRate = (data?[fromCurrency.id] as num?)?.toDouble();
    final toRate = (data?[toCurrency.id] as num?)?.toDouble();
    // Never print a rate we do not have: a missing code would otherwise show
    // a fabricated 1:1 rate from a `?? 1.0` fallback.
    final bool rateUnavailable =
        data != null &&
        data.isNotEmpty &&
        (fromRate == null || toRate == null || fromRate == 0);
    final rateText = data == null || data.isEmpty
        ? (_failed ? "Rates unavailable offline" : "Fetching rates...")
        : rateUnavailable
        ? "Rate unavailable"
        : "1 ${fromCurrency.id} = ${(toRate! / fromRate!).toStringAsFixed(4)} ${toCurrency.id}";
    final statusText = _lastUpdated == "-"
        ? rateText
        : "$rateText · Updated $_lastUpdated";

    return Scaffold(
      backgroundColor: p.bg,
      extendBodyBehindAppBar: true,
      appBar: TopBar(
        title: Units.currency.label,
        trailing: TopBarAction(
          icon: AppIcons.swap,
          tooltip: 'Swap currencies',
          onPressed: _swap,
        ),
      ),
      body: ReadableWidth(
        child: Padding(
          padding: EdgeInsets.only(top: Tokens.topBarInset(context)),
          child: LayoutBuilder(
            builder: (context, box) {
              final keypad = Keypad(
                controller: _isFirstFieldSelected
                    ? _firstFieldController
                    : _secondFieldController,
                onChanged: () => convert(firstFieldIndex, secondFieldIndex),
              );
              final fields = [
                const SizedBox(height: Gaps.sm),
                FieldListTile(
                  list: Currency.currenciesList,
                  title: 'Currency',
                  isCurrency: true,
                  controller: _firstFieldController,
                  isFieldSelected: _isFirstFieldSelected,
                  fieldIndex: firstFieldIndex,
                  onFieldSelect: () {
                    setState(() => _isFirstFieldSelected = true);
                  },
                  onLabelSelect: () {
                    setState(() => _isFirstLabelSelected = true);
                    convert(firstFieldIndex, secondFieldIndex);
                  },
                  changeSelectedIndex: changeSelectedIndex,
                ),
                FieldListTile(
                  list: Currency.currenciesList,
                  title: 'Currency',
                  isCurrency: true,
                  isOutput: true,
                  controller: _secondFieldController,
                  isFieldSelected: !_isFirstFieldSelected,
                  fieldIndex: secondFieldIndex,
                  onFieldSelect: () {
                    setState(() => _isFirstFieldSelected = false);
                  },
                  onLabelSelect: () {
                    setState(() => _isFirstLabelSelected = false);
                    convert(firstFieldIndex, secondFieldIndex);
                  },
                  changeSelectedIndex: changeSelectedIndex,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Gaps.lg,
                    Gaps.xs,
                    Gaps.xs,
                    0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          statusText,
                          textAlign: TextAlign.center,
                          style: AppText.callout.copyWith(
                            color: rateUnavailable || _failed
                                ? p.danger
                                : p.label2,
                          ),
                        ),
                      ),
                      TopBarAction(
                        icon: AppIcons.refresh,
                        tooltip: 'Refresh rates',
                        onPressed: _isRefreshing
                            ? null
                            : () => _load(refreshing: true),
                      ),
                    ],
                  ),
                ),
              ];
              if (box.maxWidth > box.maxHeight) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: fields),
                      ),
                    ),
                    SizedBox(width: box.maxWidth / 2, child: keypad),
                  ],
                );
              }
              return Column(
                children: [
                  ...fields,
                  Expanded(child: keypad),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
