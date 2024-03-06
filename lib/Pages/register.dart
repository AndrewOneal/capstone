import 'package:flutter/material.dart';
import 'package:capstone/Utilities/theme.dart';
import 'home.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
              Text('Register', style: Theme.of(context).textTheme.titleLarge!),
              const SizedBox(height: 10),
              const RegisterForm(),
              const SizedBox(height: 60),
              DarkButton(buttonText: "Register"),
              const SizedBox(height: 20),
              Text("Already have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 20)),
              DarkButton(
                buttonText: "Click to Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
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

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

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
            labelText: 'Email',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
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
