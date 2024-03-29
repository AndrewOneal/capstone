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
              TwoLineTitle(
                  firstLineText: "Welcome Back", secondLineText: username),
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
