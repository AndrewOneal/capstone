import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Pages/Account/register.dart';
import 'package:capstone/Pages/Account/account.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              const ListTitle(title: "Login"),
              smallSizedBox,
              const LoginFields(),
              extraLargeSizedBox,
              DarkButton(
                buttonText: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountPage()),
                  );
                },
              ),
              mediumSizedBox,
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Don't have an account?",
                    style: TextStyles.disclaimerText),
              ),
              smallSizedBox,
              DarkButton(
                buttonText: "Click to Register",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFields extends StatelessWidget {
  const LoginFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
