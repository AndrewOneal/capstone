import 'package:flutter/material.dart';
import 'theme.dart';

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
          textStyle: Theme.of(context).textTheme.bodyLarge,
        ),
        child: Text(buttonText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                )),
      ),
    );
  }
}
