import 'package:capstone/Utilities/theme.dart';
import 'package:flutter/material.dart';
import 'Account/login.dart';
import 'tutorial.dart';
import 'package:capstone/main.dart';
import 'Wiki/wiki_home.dart';

class WikiListPage extends StatelessWidget {
  const WikiListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const Expanded(
                    child: WikiList(),
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

class WikiList extends StatelessWidget {
  const WikiList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wikiTitles = dbHandler.getTitles();
    return ListView.separated(
      itemCount: wikiTitles.length + 1,
      separatorBuilder: (BuildContext context, int index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Divider(),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == wikiTitles.length) {
          return Padding(
            padding: const EdgeInsets.only(right: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Don't see what you're looking for? Hit the plus to create your own community!",
                        style: Theme.of(context).textTheme.displayMedium!,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return index.isEven
              ? LightPurpleButton2(
                  buttonText: wikiTitles[index],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WikiHome(
                          wikiTitle: wikiTitles[index],
                          wikiID: index,
                        ),
                      ),
                    );
                  },
                )
              : LightPurpleButton1(
                  buttonText: wikiTitles[index],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WikiHome(
                          wikiTitle: wikiTitles[index],
                          wikiID: index,
                        ),
                      ),
                    );
                  },
                );
        }
      },
    );
  }
}
