import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.icon,
    this.text,
    this.textStyle,
    this.iconColor,
    this.backgroundColor,
    this.isScientic = false,
    this.onPressed,
  });

  final IconData? icon;
  final String? text;
  final TextStyle? textStyle;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isScientic;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: backgroundColor ??
            Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
      ),
      icon: SizedBox(
        height: MediaQuery.of(context).size.height / (isScientic ? 10 : 7),
        width: MediaQuery.of(context).size.width / (isScientic ? 10 : 7),
        child: Center(
          child: icon == null
              ? Text(
                  text ?? "",
                  style: textStyle ??
                      const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                )
              : Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
