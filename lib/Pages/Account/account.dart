import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import '../wiki_list.dart';
import 'change_password.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: Column(
            children: [
              titleSizedBox,
              Text('Account', style: Theme.of(context).textTheme.titleLarge!),
              const SizedBox(height: 10),
              const AccountFields(),
              const SizedBox(height: 60),
              const DarkButton(buttonText: "Update Account"),
              const SizedBox(height: 20),
              DarkButton(
                buttonText: "Change Password",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CPPage()),
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

class AccountFields extends StatelessWidget {
  const AccountFields({Key? key}) : super(key: key);

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
