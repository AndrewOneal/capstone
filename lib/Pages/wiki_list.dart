import 'package:flutter/material.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/tutorial.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Wiki/wiki_home.dart';
import 'package:capstone/Pages/CRUD/new_wiki.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Account/account.dart';
//import 'package:pocketbase_server_flutter/pocketbase_server_flutter.dart';

class WikiListPage extends StatelessWidget {
  const WikiListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
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
          child: const Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTitle(title: "All Wikis"),
                  Expanded(
                    child: _WikiList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: pb.authStore.isValid
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewWiki()),
                  );
                },
                child: const Icon(Icons.add),
              ),
            )
          : null,
    );
  }
}

class _WikiList extends StatelessWidget {
  const _WikiList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: DBHandler().getWikis(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> wikiTitles = snapshot.data!;
          return ListView.separated(
            itemCount: wikiTitles.length + 1,
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(
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
                      ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 100),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Don't see what you're looking for? Hit the plus to create your own community!",
                              style: TextStyles.disclaimerText,
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
                        buttonText: wikiTitles[index]['wiki_name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WikiHome(wikiMap: wikiTitles[index]),
                            ),
                          );
                        },
                      )
                    : LightPurpleButton1(
                        buttonText: wikiTitles[index]['wiki_name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WikiHome(wikiMap: wikiTitles[index])),
                          );
                        },
                      );
              }
            },
          );
        }
      },
    );
  }
}
