import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../utils/constants.dart';

class UtilityButton extends StatefulWidget {
  final String buttonText;
  final Color colorText;
  final VoidCallback onPressed;
  final NeumorphicBoxShape buttonBoxShape;
  final double buttonWidth;
  final Color buttonColor;

  const UtilityButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.buttonWidth = 12,
    this.buttonColor = kEqualColor,
    this.colorText = kWhiteColorText,
    this.buttonBoxShape = const NeumorphicBoxShape.circle(),
  }) : super(key: key);

  @override
  State<UtilityButton> createState() => _UtilityButtonState();
}

class _UtilityButtonState extends State<UtilityButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: widget.onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 0,
        color: widget.buttonColor,
        boxShape: widget.buttonBoxShape,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / widget.buttonWidth,
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              color: widget.colorText,
              fontSize: 28,
              fontFamily: 'PTSans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
