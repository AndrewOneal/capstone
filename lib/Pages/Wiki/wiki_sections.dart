import 'package:capstone/Utilities/global.dart';
import 'package:flutter/material.dart';
import 'package:capstone/Pages/Account/login.dart';
import '../Account/wiki_settings.dart';

class WikiSectionsPage extends StatelessWidget {
  final int wikiID;
  final int wikiSettingID;
  const WikiSectionsPage(
      {Key? key, required this.wikiID, required this.wikiSettingID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      builder: (context) => WikiSettings(wikiID: wikiID)),
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
                  const ListTitle(title: "Sections"),
                  Expanded(
                    child: _SectionList(wikiID: wikiID),
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

class _SectionList extends StatelessWidget {
  final int wikiID;
  const _SectionList({Key? key, required this.wikiID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectionList = dbHandler.getSections(id: wikiID);
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemCount: sectionList.length + 1,
        separatorBuilder: (BuildContext context, int index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(),
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == sectionList.length) {
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
                          "Don't see the section you're looking for? Hit the edit button to add it!",
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
                    buttonText: sectionList[index],
                    onPressed: () {},
                  )
                : LightPurpleButton1(
                    buttonText: sectionList[index],
                    onPressed: () {},
                  );
          }
        },
      ),
    );
  }
}