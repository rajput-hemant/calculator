import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';

/// A flat top-bar icon button: a 48 dp circle with a muted glyph. [selected]
/// (non-null makes it a toggle) fills it with the accent wash.
class TopBarAction extends StatelessWidget {
  const TopBarAction({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.selected,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final on = selected ?? false;
    final border = AppShapes.of(context).border(Tokens.control / 2);
    return Semantics(
      button: true,
      toggled: selected,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            decoration: ShapeDecoration(
              shape: border,
              color: on ? p.accentSoft : null,
            ),
            child: InkResponse(
              onTap: onPressed,
              customBorder: border,
              radius: Tokens.control / 2,
              child: SizedBox.square(
                dimension: Tokens.control,
                child: Icon(icon, size: 24, color: on ? p.accent : p.label2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Back button for inner screens.
class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) => TopBarAction(
    icon: AppIcons.back,
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    onPressed: () => Navigator.maybePop(context),
  );
}

/// A flat accent text button for the top bar ("Clear").
class TopBarTextAction extends StatelessWidget {
  const TopBarTextAction({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        customBorder: AppShapes.of(context).border(Tokens.control / 2),
        child: Container(
          height: Tokens.control,
          padding: const EdgeInsets.symmetric(horizontal: Gaps.lg),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppText.callout.copyWith(
              color: p.accent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Floating top bar: flat controls over the content, title next to the
/// leading control. Use as `Scaffold.appBar` with `extendBodyBehindAppBar:
/// true` and pad content by [Tokens.topBarInset]. Content scrolling
/// underneath fades out behind it (the iOS scroll edge effect).
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key, this.leading, this.title, this.trailing});

  /// Defaults to [_BackButton] when the route can pop.
  final Widget? leading;
  final String? title;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(Tokens.topBarHeight);

  @override
  Widget build(BuildContext context) {
    // Palette.of first: it subscribes to theme changes; the Scaffold lookup
    // alone would leave this const bar painting the previous theme's color.
    final p = Palette.of(context);
    final edge =
        context.findAncestorWidgetOfExactType<Scaffold>()?.backgroundColor ??
        p.bg;
    final lead =
        leading ?? (Navigator.canPop(context) ? const _BackButton() : null);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [edge, edge, edge.withValues(alpha: 0)],
          stops: const [0, 0.6, 1],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: Tokens.topBarHeight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Gaps.xs, 0, Gaps.sm, 0),
            child: Row(
              children: [
                ?lead,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: Gaps.md),
                    child: Text(
                      title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.title.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
