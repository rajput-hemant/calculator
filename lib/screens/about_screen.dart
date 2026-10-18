import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_info_provider.dart';
import '../theme/app_icons.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';
import '../widgets/brand_mark.dart';
import '../widgets/glass.dart';
import '../widgets/grouped_list.dart';
import '../widgets/readable_width.dart';
import '../widgets/url_launcher.dart';
import '../widgets/top_bar.dart';

const _repoUrl = 'https://github.com/rajput-hemant/calculator';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  static const double _markSize = 96;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(appVersionProvider);
    final p = Palette.of(context);

    return Scaffold(
      backgroundColor: p.grouped,
      extendBodyBehindAppBar: true,
      appBar: const TopBar(),
      body: ReadableWidth(
        child: ListView(
          padding: EdgeInsets.only(
            top: Tokens.topBarInset(context),
            bottom: Gaps.huge,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: Gaps.xl),
              child: Column(
                children: [
                  Semantics(
                    image: true,
                    label: 'Calculator logo',
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_markSize * 0.26),
                        boxShadow: Glass.shadow(p),
                      ),
                      child: const BrandMark(size: _markSize),
                    ),
                  ),
                  const SizedBox(height: Gaps.lg),
                  Text(
                    'Calculator',
                    style: AppText.largeTitle.copyWith(
                      fontSize: 28,
                      height: 34 / 28,
                      color: p.label,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Version ${version.value ?? ''}',
                    style: AppText.callout.copyWith(color: p.label2),
                  ),
                  const SizedBox(height: Gaps.sm),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'A simple, elegant calculator with unit and currency converters.',
                      textAlign: TextAlign.center,
                      style: AppText.callout.copyWith(color: p.label2),
                    ),
                  ),
                ],
              ),
            ),
            InsetGroup(
              children: [
                GroupCell(
                  leading: const IconTile(AppIcons.code),
                  title: 'Source code',
                  subtitle: 'github.com/rajput-hemant/calculator',
                  trailing: Icon(
                    AppIcons.openExternal,
                    size: 18,
                    color: p.label3,
                  ),
                  onTap: () => openUrl(context, _repoUrl),
                ),
                GroupCell(
                  leading: const IconTile(AppIcons.bug),
                  title: 'Report an issue',
                  trailing: Icon(
                    AppIcons.openExternal,
                    size: 18,
                    color: p.label3,
                  ),
                  onTap: () => openUrl(context, '$_repoUrl/issues'),
                ),
                GroupCell(
                  leading: const IconTile(AppIcons.licenses),
                  title: 'Open-source licenses',
                  chevron: true,
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: 'Calculator',
                    applicationVersion: version.value,
                    applicationIcon: const BrandMark(size: 48),
                  ),
                ),
              ],
            ),
            const SectionFooter('Made with Flutter', center: true),
          ],
        ),
      ),
    );
  }
}
