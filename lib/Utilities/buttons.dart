import 'package:flutter/material.dart';
import 'package:capstone/Utilities/theme.dart';

class DarkButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double buttonWidth;

  const DarkButton(
      {Key? key,
      required this.buttonText,
      this.buttonWidth = double.infinity,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var function = onPressed ?? () {};

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttons['default'],
          foregroundColor: text['default'],
          textStyle: TextStyles.whiteButtonText,
          alignment: Alignment.center,
        ),
        child: Text(buttonText),
      ),
    );
  }
}

class LightPurpleButton1 extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double buttonWidth;

  const LightPurpleButton1(
      {Key? key,
      required this.buttonText,
      this.buttonWidth = double.infinity,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var function = onPressed ?? () {};

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: function,
        child: Text(buttonText, style: TextStyles.blackButtonText),
      ),
    );
  }
}

class LightPurpleButton2 extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double buttonWidth;

  const LightPurpleButton2(
      {Key? key,
      required this.buttonText,
      this.buttonWidth = double.infinity,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var function = onPressed ?? () {};

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttons['400'],
        ),
        child: Text(buttonText, style: TextStyles.blackButtonText),
      ),
    );
  }
}
