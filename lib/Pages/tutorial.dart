import 'package:flutter/material.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/account.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/apis.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
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
        actions: [
          IconButton(
              icon: const Icon(Icons.list_alt),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const APIListPage()),
                );
              }),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => pb.authStore.isValid
                        ? const AccountPage()
                        : const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _TitleText(),
              mediumSizedBox,
              const _CardWidget(),
              mediumSizedBox,
              DarkButton(
                buttonText: 'Get Started',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WikiListPage()),
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

class _TitleText extends StatelessWidget {
  const _TitleText();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Spoiler',
                style: TextStyles.whiteHeader.copyWith(height: 0.8),
              ),
              TextSpan(
                text: 'Guard',
                style: TextStyles.purpleHeader.copyWith(height: 0.8),
              ),
            ],
          ),
        ),
        Text(
          'The Spoiler-Free Wikipedia',
          style: TextStyles.titleSmall,
        ),
      ],
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget();

  final cardPadding = const EdgeInsets.all(10);
  final textSpacing = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Center(
              child: Text(
                'Welcome to SpoilerGuard, the spoiler-free wikipedia made to keep you safe! Begin your search by following these 3 easy steps.',
                style: TextStyles.cardText,
                textAlign: TextAlign.center,
              ),
            ),
            textSpacing,
            Text(
                "1. Search for your favorite series\n2. Select the part of the series you are on\n3. Enjoy your spoiler-free experience!",
                style: TextStyles.cardText),
          ],
        ),
      ),
    );
  }
}
