import 'package:flutter/material.dart';
import 'package:capstone/Utilities/theme.dart';

class DarkButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double buttonWidth;

  const DarkButton(
      {super.key,
      required this.buttonText,
      this.buttonWidth = double.infinity,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    var function = onPressed ?? () {};

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return buttons['700']!;
              }
              return buttons['default']!;
            },
          ),
          foregroundColor: MaterialStateProperty.all(text['default']),
          textStyle: MaterialStateProperty.all(TextStyles.whiteButtonText),
          alignment: Alignment.center,
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class LightPurpleButton1 extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double buttonWidth;

  const LightPurpleButton1(
      {super.key,
      required this.buttonText,
      this.buttonWidth = double.infinity,
      this.onPressed});

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
      {super.key,
      required this.buttonText,
      this.buttonWidth = double.infinity,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    var function = onPressed ?? () {};

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return buttons['300']!;
              }
              return buttons['400']!;
            },
          ),
        ),
        child: Text(buttonText, style: TextStyles.blackButtonText),
      ),
    );
  }
}
