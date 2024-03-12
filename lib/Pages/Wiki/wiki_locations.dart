import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';
import 'package:capstone/Pages/Wiki/wiki_details.dart';

class WikiLocationsPage extends StatelessWidget {
  final int wikiID;
  final int wikiSettingID;
  const WikiLocationsPage(
      {Key? key, required this.wikiID, required this.wikiSettingID})
      : super(key: key);

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
                  const ListTitle(title: "Locations"),
                  Expanded(
                    child: _LocationList(
                        wikiID: wikiID, wikiSettingID: wikiSettingID),
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

class _LocationList extends StatelessWidget {
  final int wikiID;
  final int wikiSettingID;
  const _LocationList(
      {Key? key, required this.wikiID, required this.wikiSettingID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Future.value(DBHandler().getLocations(id: wikiID)),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        } else {
          final locationList = snapshot.data!;
          return SizedBox(
            height: 300,
            child: ListView.separated(
              itemCount: locationList.length + 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(),
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == locationList.length) {
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
                                "Don't see the location you're looking for? Hit the edit button to add it!",
                                style:
                                    Theme.of(context).textTheme.displayMedium!,
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
                          buttonText: locationList[index],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WikiDetailsPage(
                                      wikiID: wikiID,
                                      wikiSettingID: wikiSettingID,
                                      wikiDetailTitle: locationList[index],
                                      wikiDetailID: 2)),
                            );
                          },
                        )
                      : LightPurpleButton1(
                          buttonText: locationList[index],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WikiDetailsPage(
                                      wikiID: wikiID,
                                      wikiSettingID: wikiSettingID,
                                      wikiDetailTitle: locationList[index],
                                      wikiDetailID: 2)),
                            );
                          },
                        );
                }
              },
            ),
          );
        }
      },
    );
  }
}
