import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Utilities/db_util.dart';
// import convert
import 'dart:convert';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final String username =
        json.decode(pb.authStore.model.toString())['username'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WikiListPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: sideMargins,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _WelcomeText(username: username),
              DarkButton(
                buttonText: "Logout",
                onPressed: () {
                  pb.authStore.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WikiListPage()),
                  );
                },
              ),
              mediumSizedBox,
              DarkButton(
                  buttonText: "Admin Panel",
                  onPressed: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()),
                    );*/
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  final String username;

  const _WelcomeText({required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: background['default'],
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Welcome Back',
              style: TextStyles.whiteHeader.copyWith(height: 1.2),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              username,
              style: TextStyles.purpleHeader.copyWith(height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
