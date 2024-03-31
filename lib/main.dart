import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/tutorial.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:pocketbase_server_flutter/pocketbase_server_flutter.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var homePage = initScreen == 0 || initScreen == null
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
