import 'package:capstone/Utilities/theme.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleSpacing = 40.0;
    const cardSpacing = 16.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TitleText(),
            const SizedBox(height: titleSpacing),
            const CardWidget(),
            const SizedBox(height: cardSpacing),
            DarkButton(buttonText: 'Get Started', buttonWidth: double.infinity),
          ],
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Spoiler',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(height: 0.8),
              ),
              TextSpan(
                text: 'Guard',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(height: 0.8),
              ),
            ],
          ),
        ),
        Text(
          'The Spoiler-Free Wikipedia',
          style: Theme.of(context).textTheme.titleSmall!,
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  final cardPadding = const EdgeInsets.all(10);
  final textSpacing = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: sideMargins,
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Center(
              child: Text(
                'Welcome to SpoilerGuard, the spoiler-free wikipedia made to keep you safe! Begin your search by following these 3 easy steps.',
                style: Theme.of(context).textTheme.bodyMedium!,
                textAlign: TextAlign.center,
              ),
            ),
            textSpacing,
            Text(
                "1. Search for your favorite series\n2. Select the part of the series you are on\n3. Enjoy your spoiler-free experience!",
                style: Theme.of(context).textTheme.bodyMedium!),
          ],
        ),
      ),
    );
  }
}
