import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Pages/Account/change_password.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox titleSizedBox = global.titleSizedBox;
    final SizedBox smallSizedBox = global.smallSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final SizedBox mediumSizedBox = global.mediumSizedBox;
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
              titleSizedBox,
              const ListTitle(title: "Account"),
              smallSizedBox,
              const AccountFields(),
              extraLargeSizedBox,
              const DarkButton(buttonText: "Update Account"),
              mediumSizedBox,
              DarkButton(
                buttonText: "Change Password",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CPPage()),
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

class AccountFields extends StatelessWidget {
  const AccountFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
          initialValue: 'Test User',
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
          initialValue: 'Test User Email',
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
