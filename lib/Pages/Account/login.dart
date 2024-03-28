import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Pages/Account/register.dart';
import 'package:capstone/Pages/Account/account.dart';
import 'package:capstone/Utilities/db_util.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox titleSizedBox = global.titleSizedBox;
    final SizedBox smallSizedBox = global.smallSizedBox;
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
              const LoginForm(),
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final DBHandler dbHandler = DBHandler();
    final formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
            controller: usernameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
            obscureText: true,
          ),
          extraLargeSizedBox,
          DarkButton(
            buttonText: "Login",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(
                          content: Text('Logging In'),
                          duration: Duration(seconds: 1)),
                    )
                    .closed
                    .then((reason) {
                  if (pb.authStore.isValid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Invalid username or password')),
                    );
                  }
                });
                try {
                  dbHandler.authenticate(
                      username: usernameController.text,
                      password: passwordController.text);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Invalid username or password')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill out all fields')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
