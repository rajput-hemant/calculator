import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_shapes.dart';
import '../theme/palette.dart';
import '../theme/tokens.dart';

// Saturation 1.8, applied under the blur so colors behind the glass glow.
const List<double> _saturate = [
  1.6362, -0.5726, -0.0636, 0, 0, //
  -0.1638, 1.2274, -0.0636, 0, 0, //
  -0.1638, -0.5726, 1.7364, 0, 0, //
  0, 0, 0, 1, 0, //
];

/// Liquid Glass approximation: blur + saturation + tint + rim + shadow.
///
/// ponytail: no lensing or refraction (needs a shader); swap for a real
/// glass material if Flutter ships one.
class Glass extends StatelessWidget {
  const Glass({super.key, required this.child, this.shape, this.color});

  final Widget child;

  /// Defaults to the control shape of the key style.
  final OutlinedBorder? shape;

  /// Overrides the glass tint, for tinted (accent) glass.
  final Color? color;

  /// The faint lift glass surfaces cast, kept shallow so controls read flat
  /// as in the mockup. Reuse it for floating marks.
  static List<BoxShadow> shadow(Palette p) => [
    BoxShadow(color: p.glassShadow, blurRadius: 12, offset: const Offset(0, 2)),
  ];

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final border = shape ?? AppShapes.of(context).border(Radii.control);
    return DecoratedBox(
      decoration: ShapeDecoration(shape: border, shadows: shadow(p)),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: border),
        // Shares one backdrop read with every other glass surface on screen
        // (BackdropGroup in main.dart).
        child: BackdropFilter.grouped(
          filter: ui.ImageFilter.compose(
            outer: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            inner: const ColorFilter.matrix(_saturate),
          ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              color: color ?? p.glass,
              shape: border.copyWith(
                side: BorderSide(color: p.glassRim, width: 0.8),
              ),
            ),
            // Gives ink splashes a surface above the tint.
            child: Material(type: MaterialType.transparency, child: child),
          ),
        ),
      ),
    );
  }
}

/// A flat top-bar icon button: a 48 dp circle with a muted glyph. [selected]
/// (non-null makes it a toggle) fills it with the accent wash.
class GlassAction extends StatelessWidget {
  const GlassAction({
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
    final border = AppShapes.of(context).border(Tokens.glassControl / 2);
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
              radius: Tokens.glassControl / 2,
              child: SizedBox.square(
                dimension: Tokens.glassControl,
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
class GlassBackButton extends StatelessWidget {
  const GlassBackButton({super.key});

  @override
  Widget build(BuildContext context) => GlassAction(
    icon: AppIcons.back,
    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    onPressed: () => Navigator.maybePop(context),
  );
}

/// A flat accent text button for the top bar ("Clear").
class GlassTextAction extends StatelessWidget {
  const GlassTextAction({
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
        customBorder: AppShapes.of(context).border(Tokens.glassControl / 2),
        child: Container(
          height: Tokens.glassControl,
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
class GlassTopBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassTopBar({super.key, this.leading, this.title, this.trailing});

  /// Defaults to [GlassBackButton] when the route can pop.
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
        leading ?? (Navigator.canPop(context) ? const GlassBackButton() : null);
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
