import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/tutorial.dart';
import 'package:capstone/Pages/wiki_list.dart';

int? _initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _initScreen = prefs.getInt('_initScreen');
  await prefs.setInt('_initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homePage = _initScreen == 0 || _initScreen == null
        ? const TutorialPage()
        : const WikiListPage();

    return MaterialApp(
      home: homePage,
      scrollBehavior: _SGScrollBehavior(),
      title: 'SpoilerGuard',
      theme: defaultTheme,
    );
  }
}

class _SGScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
