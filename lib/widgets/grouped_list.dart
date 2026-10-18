import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';

/// 34 pt bold page title that scrolls with the content (iOS large title).
class LargeTitle extends StatelessWidget {
  const LargeTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Text(text, style: AppText.largeTitle),
    );
  }
}

/// Uppercase caption above an [InsetGroup].
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 18, 36, 7),
      child: Text(
        text.toUpperCase(),
        style: AppText.footnote.copyWith(color: Palette.of(context).label2),
      ),
    );
  }
}

/// Muted note under an [InsetGroup].
class SectionFooter extends StatelessWidget {
  const SectionFooter(this.text, {super.key, this.center = false});

  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 7, 36, 0),
      child: Text(
        text,
        textAlign: center ? TextAlign.center : TextAlign.start,
        style: AppText.footnote.copyWith(color: Palette.of(context).label2),
      ),
    );
  }
}

/// A rounded (26 pt) group of [GroupCell]s with hairline separators.
class InsetGroup extends StatelessWidget {
  const InsetGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gaps.lg),
      child: Material(
        color: p.cell,
        shape: AppShapes.of(context).border(Radii.card),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0)
                Padding(
                  // Separators start where the text does.
                  padding: EdgeInsets.only(
                    left: switch (children[i]) {
                      GroupCell(leading: _?) => 62,
                      _ => 18,
                    },
                  ),
                  child: const Divider(),
                ),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

/// One row of an [InsetGroup]. When [below] is set (a segmented control,
/// slider or swatches) it sits under the title, full width.
class GroupCell extends StatelessWidget {
  const GroupCell({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.below,
    this.onTap,
    this.selected = false,
    this.chevron = false,
  });

  final String title;
  final String? subtitle;

  /// Usually an [IconTile].
  final Widget? leading;
  final Widget? trailing;
  final Widget? below;
  final VoidCallback? onTap;

  /// Accent label and a check mark.
  final bool selected;

  /// Adds a disclosure chevron after [trailing].
  final bool chevron;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final titleStyle = AppText.body.copyWith(
      color: selected ? p.accent : p.label,
      fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
    );
    // A plain row reads as one item (label plus switch); rows with controls
    // underneath keep each control separately focusable.
    final cell = InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 52),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 14)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppText.footnote.copyWith(color: p.label2),
                      ),
                    if (below != null) ...[const SizedBox(height: 10), below!],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 8),
                DefaultTextStyle.merge(
                  style: AppText.body.copyWith(color: p.label2),
                  child: trailing!,
                ),
              ],
              if (selected) ...[
                const SizedBox(width: 8),
                Icon(AppIcons.check, size: 20, color: p.accent),
              ],
              if (chevron) ...[
                const SizedBox(width: 6),
                Icon(AppIcons.chevronRight, size: 18, color: p.label3),
              ],
            ],
          ),
        ),
      ),
    );
    return below == null ? MergeSemantics(child: cell) : cell;
  }
}

/// 30 pt accent square holding a white icon, for list rows.
class IconTile extends StatelessWidget {
  const IconTile(this.icon, {super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      width: 30,
      height: 30,
      decoration: ShapeDecoration(
        color: p.accent,
        shape: AppShapes.of(context).border(Radii.sm),
      ),
      child: Icon(icon, size: 19, color: p.onAccent),
    );
  }
}
