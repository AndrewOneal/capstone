import 'package:flutter/material.dart';
import 'theme.dart';

class DarkButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double buttonWidth;

  const DarkButton(
      {Key? key,
      required this.buttonText,
      this.buttonWidth = 300.0,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var function = onPressed ?? () {};
    return Padding(
      padding: sideMargins,
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttons['default'],
            foregroundColor: text['default'],
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
