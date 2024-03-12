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
      body: Padding(
        padding: sideMargins,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTitle(title: detailName, fontSize: 40),
                Expanded(
                  child: _DetailList(
                      wikiID: wikiID,
                      wikiSettingID: wikiSettingID,
                      wikiDetailID: wikiDetailID),
                ),
              ],
            ),
          ],
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

class _DetailList extends StatelessWidget {
  final int wikiID;
  final int wikiSettingID;
  final int wikiDetailID;
  const _DetailList(
      {Key? key,
      required this.wikiID,
      required this.wikiSettingID,
      required this.wikiDetailID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DBHandler dbHandler = DBHandler();
    Global global = Global();
    SizedBox mediumSizedBox = global.mediumSizedBox;
    String loremIpsum = global.loremIpsum;
    return FutureBuilder<List<String>>(
        future: Future.value(DBHandler().getWikiDetailsPage(
            wikiID: wikiID,
            wikiSettingID: wikiSettingID,
            wikiDetailID: wikiDetailID)),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return ErrorWidget(snapshot.error!);
          } else {
            final headerList = snapshot.data!;
            return SizedBox(
              height: 400,
              child: ListView.separated(
                itemCount: headerList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    mediumSizedBox,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        headerList[index],
                        style: Theme.of(context).textTheme.headlineMedium!,
                      ),
                      const Divider(),
                      Text(
                        loremIpsum,
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                    ],
                  );
                },
              ),
            );
          }
        });
  }
}
