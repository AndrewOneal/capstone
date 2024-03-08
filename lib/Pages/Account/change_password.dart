import 'package:flutter/material.dart';
import 'package:capstone/Utilities/theme.dart';
import 'account.dart';

class CPPage extends StatelessWidget {
  const CPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: Column(
            children: [
              const SizedBox(height: 75),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Change Password',
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
              ),
              const SizedBox(height: 10),
              const CPFields(),
              const SizedBox(height: 60),
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
  const CPFields({Key? key}) : super(key: key);

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
