import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';

class WikiDetailsPage extends StatelessWidget {
  final int wikiID;
  final int wikiSettingID;
  final int wikiDetailID;
  final String wikiDetailTitle;
  const WikiDetailsPage(
      {Key? key,
      required this.wikiID,
      required this.wikiSettingID,
      required this.wikiDetailID,
      this.wikiDetailTitle = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailName = wikiDetailTitle;
    final DBHandler dbHandler = DBHandler();
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
                  ListTitle(title: detailName),
                  /*Expanded(
                    child: _CharacterList(wikiID: wikiID),
                  ),*/
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
