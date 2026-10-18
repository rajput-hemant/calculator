import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../provider/preferences_provider.dart';
import '../theme/app_icons.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../utils/text_editing.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';
import '../widgets/readable_width.dart';
import '../widgets/top_bar.dart';

/// Drops the ".0" that `Double.toString` leaves on whole numbers.
String _plain(String text) =>
    text.endsWith('.0') ? text.substring(0, text.length - 2) : text;

/// One conversion screen for every [Units] category, replacing the 14
/// per-category screens.
class ConversionScreen extends ConsumerStatefulWidget {
  const ConversionScreen({super.key, required this.category});

  final Units category;

  @override
  ConsumerState<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends ConsumerState<ConversionScreen> {
  final TextEditingController _firstFieldController = textEditingController(
    "1",
  );
  final TextEditingController _secondFieldController = textEditingController(
    "100",
  );

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  List<Unit> get _units => widget.category.units;

  void convert() {
    final [firstFieldIndex, secondFieldIndex] = ref
        .read(preferencesProvider)
        .unitIndexes[widget.category]!;

    setState(() {
      convertUnit(
        _firstFieldController,
        _secondFieldController,
        firstFieldIndex,
        secondFieldIndex,
        _units,
        _isFirstFieldSelected,
      );
      final output = _isFirstFieldSelected
          ? _secondFieldController
          : _firstFieldController;
      setTextKeepingCaret(output, _plain(output.text));
    });
  }

  void changeSelectedIndex(int index) {
    final [firstFieldIndex, secondFieldIndex] = ref
        .read(preferencesProvider)
        .unitIndexes[widget.category]!;

    ref
        .read(preferencesProvider.notifier)
        .setUnitIndexes(
          widget.category,
          _isFirstLabelSelected
              ? [index, secondFieldIndex]
              : [firstFieldIndex, index],
        );

    convert();
  }

  void swapUnits() {
    final [firstFieldIndex, secondFieldIndex] = ref
        .read(preferencesProvider)
        .unitIndexes[widget.category]!;

    final firstValue = _firstFieldController.text;
    setTextKeepingCaret(_firstFieldController, _secondFieldController.text);
    setTextKeepingCaret(_secondFieldController, firstValue);

    setState(() {
      // The value the user was typing stays under the keypad's fingers.
      _isFirstFieldSelected = !_isFirstFieldSelected;
      _isFirstLabelSelected = !_isFirstLabelSelected;
    });

    ref.read(preferencesProvider.notifier).setUnitIndexes(widget.category, [
      secondFieldIndex,
      firstFieldIndex,
    ]);
    convert();
  }

  void _selectLabel(bool selectFirst) {
    setState(() => _isFirstLabelSelected = selectFirst);
    convert();
  }

  @override
  void initState() {
    super.initState();
    convert();
  }

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final [firstFieldIndex, secondFieldIndex] = ref
        .watch(preferencesProvider)
        .unitIndexes[widget.category]!;

    final bool sameUnit = firstFieldIndex == secondFieldIndex;
    final String? rateLine =
        sameUnit ||
            widget.category == Units.temperature ||
            widget.category == Units.fuel
        ? null
        : '1 ${_units[firstFieldIndex].id} = '
              '${_plain((_units[secondFieldIndex].rate! / _units[firstFieldIndex].rate!).toString())} '
              '${_units[secondFieldIndex].id}';

    return Scaffold(
      backgroundColor: p.bg,
      extendBodyBehindAppBar: true,
      appBar: TopBar(
        title: widget.category.label,
        trailing: TopBarAction(
          icon: AppIcons.swap,
          tooltip: 'Swap units',
          onPressed: swapUnits,
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
                onChanged: convert,
              );
              final fields = [
                const SizedBox(height: Gaps.sm),
                FieldListTile(
                  list: _units,
                  title: '${widget.category.label} unit',
                  controller: _firstFieldController,
                  isFieldSelected: _isFirstFieldSelected,
                  fieldIndex: firstFieldIndex,
                  onFieldSelect: () =>
                      setState(() => _isFirstFieldSelected = true),
                  onLabelSelect: () => _selectLabel(true),
                  changeSelectedIndex: changeSelectedIndex,
                ),
                FieldListTile(
                  list: _units,
                  title: '${widget.category.label} unit',
                  isOutput: true,
                  controller: _secondFieldController,
                  isFieldSelected: !_isFirstFieldSelected,
                  fieldIndex: secondFieldIndex,
                  onFieldSelect: () =>
                      setState(() => _isFirstFieldSelected = false),
                  onLabelSelect: () => _selectLabel(false),
                  changeSelectedIndex: changeSelectedIndex,
                ),
                if (rateLine != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Gaps.sm),
                    child: Text(
                      rateLine,
                      textAlign: TextAlign.center,
                      style: AppText.callout.copyWith(color: p.label2),
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
