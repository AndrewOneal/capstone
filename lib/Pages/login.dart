import 'package:flutter/material.dart';
import 'package:capstone/Utilities/theme.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: Column(
            children: [
              const SizedBox(height: 75),
              Text('Login', style: Theme.of(context).textTheme.titleLarge!),
              const SizedBox(height: 10),
              const LoginForm(),
              const SizedBox(height: 60),
              DarkButton(
                buttonText: "Login",
              ),
              const SizedBox(height: 20),
              Text("Don't have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20)),
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
  const LoginForm({Key? key}) : super(key: key);

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
