import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RoundButton extends StatefulWidget {
  const RoundButton(
    @required this.buttonText,
    this.colorText,
    @required this.onPressed,
    @required this.buttonBoxShape,
    this.buttonWidth,
  );

  final String buttonText;
  final Color colorText;
  final VoidCallback onPressed;
  final NeumorphicBoxShape buttonBoxShape;
  final double buttonWidth;

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
        color: const Color(0xFF171717),
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
