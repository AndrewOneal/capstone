import 'package:flutter/material.dart';
import 'theme.dart';
export 'theme.dart';
export 'package:capstone/main.dart';
export 'buttons.dart';
export 'db_util.dart';

class Global {
  static final Global _instance = Global._internal();

  factory Global() {
    return _instance;
  }

  Global._internal();

  EdgeInsets sideMargins = const EdgeInsets.symmetric(horizontal: 25);
  SizedBox titleSizedBox = const SizedBox(height: 75);
}

class ListTitle extends StatelessWidget {
  final String title;

  const ListTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: background['default'],
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!,
      ),
    );
  }
}
