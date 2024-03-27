import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';
import 'package:capstone/Pages/Wiki/wiki_details.dart';
import 'package:capstone/Utilities/db_util.dart';

class WikiCharactersPage extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;
  const WikiCharactersPage(
      {super.key, required this.wikiMap, required this.sectionNo});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WikiSettings(wikiMap: wikiMap, sectionNo: sectionNo)),
                );
              }),
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
                  const ListTitle(title: "Characters"),
                  Expanded(
                    child: _CharacterList(
                      wikiMap: wikiMap,
                      sectionNo: sectionNo,
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
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}

class _CharacterList extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;
  const _CharacterList({required this.wikiMap, required this.sectionNo});

  @override
  Widget build(BuildContext context) {
    final String wikiID = wikiMap['id'];
    DBHandler dbHandler = DBHandler();
    const String disclaimerText =
        "Don't see the character you're looking for? Hit the edit button to add them!";
    return FutureBuilder<List<dynamic>>(
      future: dbHandler.getCharacters(wikiID: wikiID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (snapshot.data!.isEmpty) {
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
                          disclaimerText,
                          style: TextStyles.disclaimerText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          List<dynamic> wikiCharacters = snapshot.data!;
          return ListView.separated(
            itemCount: wikiCharacters.length + 1,
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(),
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == wikiCharacters.length) {
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
                              disclaimerText,
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
                        buttonText: wikiCharacters[index]['name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WikiDetailsPage(
                                wikiMap: wikiMap,
                                sectionNo: sectionNo,
                                detailName: wikiCharacters[index]['name'],
                                detailType: 'Character',
                                detailMap: wikiCharacters[index],
                              ),
                            ),
                          );
                        },
                      )
                    : LightPurpleButton1(
                        buttonText: wikiCharacters[index]['name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WikiDetailsPage(
                                wikiMap: wikiMap,
                                sectionNo: sectionNo,
                                detailName: wikiCharacters[index]['name'],
                                detailType: 'Character',
                                detailMap: wikiCharacters[index],
                              ),
                            ),
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
