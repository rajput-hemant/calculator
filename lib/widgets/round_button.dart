import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../utils/constants.dart';

class RoundButton extends StatefulWidget {
  final String buttonText;
  final Color colorText, backgroundColor;
  final VoidCallback onPressed;
  final NeumorphicBoxShape buttonBoxShape;
  final double buttonWidth;

  const RoundButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.buttonWidth = 8,
    this.colorText = kWhiteColorText,
    this.buttonBoxShape = const NeumorphicBoxShape.circle(),
    this.backgroundColor = const Color(0xFF171717),
  }) : super(key: key);

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: widget.onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 0,
        color: widget.backgroundColor,
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
              fontSize: 25,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
