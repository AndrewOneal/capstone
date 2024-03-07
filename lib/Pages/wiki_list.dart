import 'package:capstone/Utilities/theme.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'tutorial.dart';

class WikiListPage extends StatelessWidget {
  const WikiListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> wikiNames = [
      "Avatar The Last Airbender",
      "Darling in the Franxx",
      "Fate",
      "Friends",
      "Harry Potter",
      "How I Met Your Mother",
      "One Piece",
      "Phineas and Ferb",
      "Regular Show",
      "Spongebob",
      "The Office",
      "The Wheel of Time",
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.question_mark),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TutorialPage()),
            );
          },
        ),
        actions: [
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
        child: Padding(
          padding: sideMargins,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: background['default'],
                    alignment: Alignment.center,
                    child: Text(
                      "All Wikis",
                      style: Theme.of(context).textTheme.titleLarge!,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: wikiNames.length + 1,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Divider(),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == wikiNames.length) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 75),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Don't see what you're looking for? Hit the plus to create your own community!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!,
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          );
                        } else {
                          return index.isEven
                              ? LightPurpleButton2(buttonText: wikiNames[index])
                              : LightPurpleButton1(
                                  buttonText: wikiNames[index]);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
