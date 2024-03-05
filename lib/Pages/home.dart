import 'package:capstone/Utilities/themes.dart';
import 'package:flutter/material.dart';

const sideMargins = EdgeInsets.symmetric(horizontal: 25);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleSpacing = 30.0;
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
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleText(),
            SizedBox(height: titleSpacing),
            CardWidget(),
            SizedBox(height: cardSpacing),
            GetStartedButton(),
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

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sideMargins,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: buttons['default']!,
            foregroundColor: text['default']!,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          child: const Text('Get Started'),
        ),
      ),
    );
  }
}
