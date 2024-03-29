import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/account.dart';

class CPPage extends StatelessWidget {
  const CPPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox titleSizedBox = global.titleSizedBox;
    final SizedBox smallSizedBox = global.smallSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(
              context,
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
              const ListTitle(title: "Change Password"),
              smallSizedBox,
              const CPFields(),
              extraLargeSizedBox,
              DarkButton(
                buttonText: "Change Password",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountPage()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CPFields extends StatelessWidget {
  const CPFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Current Password',
          ),
          obscureText: true,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'New Password',
          ),
          obscureText: true,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Confirm New Password',
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
