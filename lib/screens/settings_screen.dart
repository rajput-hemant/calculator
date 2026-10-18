import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_info_provider.dart';
import '../provider/preferences_provider.dart';
import '../routes/routes.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../widgets/controls.dart';
import '../widgets/grouped_list.dart';
import '../widgets/readable_width.dart';
import '../widgets/top_bar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);
    final version = ref.watch(appVersionProvider);
    final notifier = ref.read(preferencesProvider.notifier);
    final p = Palette.of(context);

    return Scaffold(
      backgroundColor: p.grouped,
      extendBodyBehindAppBar: true,
      appBar: const TopBar(title: 'Settings'),
      body: ReadableWidth(
        child: ListView(
          padding: EdgeInsets.only(
            top: Tokens.topBarInset(context),
            bottom: Gaps.huge,
          ),
          children: [
            const SectionHeader('Appearance'),
            InsetGroup(
              children: [
                GroupCell(
                  title: 'Theme',
                  below: PillSegmented<ThemeMode>(
                    segments: const {
                      ThemeMode.system: 'System',
                      ThemeMode.light: 'Light',
                      ThemeMode.dark: 'Dark',
                    },
                    selected: preferences.themeMode,
                    onChanged: notifier.setThemeMode,
                  ),
                ),
                GroupCell(
                  title: 'Accent',
                  below: _AccentSwatches(
                    selected: preferences.accentColor,
                    onSelected: notifier.setAccentColor,
                  ),
                ),
              ],
            ),
            const SectionHeader('Keys'),
            InsetGroup(
              children: [
                GroupCell(
                  title: 'Shape',
                  below: PillSegmented<ButtonShape>(
                    segments: const {
                      ButtonShape.round: 'Round',
                      ButtonShape.rounded: 'Rounded',
                      ButtonShape.squircle: 'Squircle',
                    },
                    selected: preferences.buttonShape,
                    onChanged: notifier.setButtonShape,
                  ),
                ),
                GroupCell(
                  title: 'Raised keys',
                  trailing: AppSwitch(
                    value:
                        preferences.buttonElevation == ButtonElevation.raised,
                    onChanged: (raised) => notifier.setButtonElevation(
                      raised ? ButtonElevation.raised : ButtonElevation.flat,
                    ),
                  ),
                ),
              ],
            ),
            const SectionHeader('Feedback'),
            InsetGroup(
              children: [
                GroupCell(
                  title: 'Haptics',
                  subtitle: 'Vibrate on key press',
                  trailing: AppSwitch(
                    value: preferences.hapticsEnabled,
                    onChanged: notifier.setHapticsEnabled,
                  ),
                ),
              ],
            ),
            const SectionHeader('About'),
            InsetGroup(
              children: [
                GroupCell(
                  title: 'Version',
                  trailing: Text(version.value ?? ''),
                ),
                GroupCell(
                  title: 'About Calculator',
                  chevron: true,
                  onTap: () => Navigator.pushNamed(context, Routes.aboutScreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentSwatches extends StatelessWidget {
  const _AccentSwatches({required this.selected, required this.onSelected});

  final int selected;
  final ValueChanged<int> onSelected;

  static const double _swatch = 30;
  static const double _ring = 38;

  static final List<(String, int)> _presets = [
    ('Blue', Tokens.seedValue),
    ('Violet', 0xFF7C4DFF),
    ('Pink', 0xFFD81B60),
    ('Orange', 0xFFF4511E),
    ('Amber', 0xFFF9A825),
    ('Green', 0xFF43A047),
    ('Teal', 0xFF00897B),
    ('Slate', 0xFF546E7A),
  ];

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final shapes = AppShapes.of(context);
    return Row(
      children: [
        for (final (name, color) in _presets)
          Expanded(
            child: Semantics(
              label: 'Accent colour $name',
              button: true,
              selected: color == selected,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onSelected(color),
                child: SizedBox(
                  height: Tokens.minTapTarget,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        if (color == selected)
                          Container(
                            width: _ring,
                            height: _ring,
                            decoration: ShapeDecoration(
                              shape: shapes
                                  .border(_ring / 2)
                                  .copyWith(
                                    side: BorderSide(color: p.label2, width: 2),
                                  ),
                            ),
                          ),
                        Container(
                          width: _swatch,
                          height: _swatch,
                          decoration: ShapeDecoration(
                            color: Color(color),
                            shape: shapes.border(_swatch / 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
