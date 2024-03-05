import 'package:flutter/material.dart';
import 'utilities/themes.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpoilerGuard',
      theme: defaultTheme,
      home: HomePage(),
    );
  }
}
