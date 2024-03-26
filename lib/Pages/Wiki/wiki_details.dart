import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
//import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';
import 'package:capstone/Utilities/db_util.dart';

class WikiDetailsPage extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;
  final String wikiDetailID;
  final String detailName;
  final String detailType;
  const WikiDetailsPage({
    super.key,
    required this.wikiMap,
    required this.sectionNo,
    required this.wikiDetailID,
    required this.detailName,
    required this.detailType,
  });

  @override
  Widget build(BuildContext context) {
    final String wikiID = wikiMap['id'];
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
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );*/
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
                      wikiSettingID: sectionNo,
                      wikiDetailID: wikiDetailID,
                      detailType: detailType),
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
  final String wikiID;
  final int wikiSettingID;
  final String wikiDetailID;
  final String detailType;

  const _DetailList({
    required this.wikiID,
    required this.wikiSettingID,
    required this.wikiDetailID,
    required this.detailType,
  });

  @override
  Widget build(BuildContext context) {
    DBHandler dbHandler = DBHandler();
    Global global = Global();
    SizedBox mediumSizedBox = global.mediumSizedBox;

    Future<Map<String, Future<List<dynamic>>>> dbHandlerGetDetails() async {
      Map<String, Future<List<dynamic>>> detailsMap = {
        'Character': dbHandler.getCharacterDetails(
          section_no: wikiSettingID,
          characterID: wikiDetailID,
        ),
        'Location': dbHandler.getLocationDetails(
          section_no: wikiSettingID,
          locationID: wikiDetailID,
        ),
      };
      if (detailType == 'Section') {
        int sectionNo =
            await dbHandler.translateSectionToNo(sectionID: wikiDetailID);
        detailsMap['Section'] = dbHandler.getSectionDetails(
          wiki_id: wikiID,
          section_no: sectionNo,
        );
      }
      return detailsMap;
    }

    const String disclaimerText =
        "Don't see the details you're looking for? Hit the edit button to add them!";

    return FutureBuilder<Map<String, Future<List<dynamic>>>>(
      future: dbHandlerGetDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, Future<List<dynamic>>> dbHandlerDetails = snapshot.data!;
          Future<List<dynamic>> futureDetails = dbHandlerDetails[detailType]!;
          return FutureBuilder<List<dynamic>>(
            future: futureDetails,
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
                List<dynamic> wikiDetails = snapshot.data!;
                return ListView.separated(
                  itemCount: wikiDetails.length + 1,
                  separatorBuilder: (BuildContext context, int index) =>
                      mediumSizedBox,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == wikiDetails.length) {
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
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (detailType != 'Section')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: background['500']!,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    wikiDetails[index]['section_name'],
                                    style: TextStyles.detailsHeaders,
                                  ),
                                ),
                              ],
                            ),
                          DefaultQuillRead(
                            input: [
                              {
                                "insert": wikiDetails[index]
                                    ['details_description'],
                              },
                              {
                                "insert": '\n',
                              }
                            ],
                          ),
                        ],
                      );
                    }
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
