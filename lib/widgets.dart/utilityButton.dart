import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class utilityButton extends StatefulWidget {
  const utilityButton(
      @required this.buttonText,
      this.colorText,
      @required this.onPressed,
      @required this.buttonBoxShape,
      this.buttonWidth,
      @required this.buttonColor);

  final String buttonText;
  final Color colorText;
  final VoidCallback onPressed;
  final NeumorphicBoxShape buttonBoxShape;
  final double buttonWidth;
  final Color buttonColor;

  @override
  State<utilityButton> createState() => _utilityButtonState();
}

class _utilityButtonState extends State<utilityButton> {
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
