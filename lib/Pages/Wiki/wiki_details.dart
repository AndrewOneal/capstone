import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/CRUD/edit_character_details.dart';
import 'package:capstone/Pages/CRUD/edit_section_details.dart';
import 'package:capstone/Pages/CRUD/edit_location_details.dart';
import 'package:capstone/Pages/Account/account.dart';

class WikiDetailsPage extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;
  final String detailName;
  final String detailType;
  final Map<String, dynamic> detailMap;

  const WikiDetailsPage({
    super.key,
    required this.wikiMap,
    required this.sectionNo,
    required this.detailName,
    required this.detailType,
    required this.detailMap,
  });

  @override
  WikiDetailsPageState createState() => WikiDetailsPageState();
}

class WikiDetailsPageState extends State<WikiDetailsPage> {
  late List<dynamic> wikiDetails = [];

  @override
  void initState() {
    super.initState();
    _fetchWikiDetails();
  }

  Future<void> _fetchWikiDetails() async {
    final details = await dbHandlerGetDetails();
    setState(() {
      wikiDetails = details;
    });
  }

  Future<List<dynamic>> dbHandlerGetDetails() async {
    final dbHandler = DBHandler();
    final Map<String, Future<List<dynamic>>> detailsMap = {
      'Character': dbHandler.getCharacterDetails(
        section_no: widget.sectionNo,
        characterID: widget.detailMap['id'],
      ),
      'Location': dbHandler.getLocationDetails(
        section_no: widget.sectionNo,
        locationID: widget.detailMap['id'],
      ),
    };
    if (widget.detailType == 'Section') {
      final int sectionNo = await dbHandler.translateSectionToNo(
          sectionID: widget.detailMap['id']);
      detailsMap['Section'] = dbHandler.getSectionDetails(
        wiki_id: widget.wikiMap['id'],
        section_no: sectionNo,
      );
    }
    return detailsMap[widget.detailType]!;
  }

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
                  builder: (context) => WikiSettings(
                    wikiMap: widget.wikiMap,
                    sectionNo: widget.sectionNo,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pb.authStore.isValid
                      ? const AccountPage()
                      : const LoginPage(),
                ),
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
                ListTitle(title: widget.detailName, fontSize: 40),
                Expanded(
                  child: _DetailList(
                    wikiID: widget.wikiMap['id'],
                    wikiSettingID: widget.sectionNo,
                    wikiDetailID: widget.detailMap['id'],
                    detailType: widget.detailType,
                    wikiDetails: wikiDetails,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: pb.authStore.isValid
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: FloatingEditButton(
                wikiMap: widget.wikiMap,
                detailMap: widget.detailMap,
                detailType: widget.detailType,
                wikiDetails: wikiDetails,
              ),
            )
          : null,
    );
  }
}

class _DetailList extends StatelessWidget {
  final String wikiID;
  final int wikiSettingID;
  final String wikiDetailID;
  final String detailType;
  final List<dynamic> wikiDetails;

  const _DetailList({
    required this.wikiID,
    required this.wikiSettingID,
    required this.wikiDetailID,
    required this.detailType,
    required this.wikiDetails,
  });

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;

    String disclaimerText = pb.authStore.isValid
        ? "Don't see the details you're looking for? Hit the edit button to add them!"
        : "Don't see the details you're looking for? Login or create an account to add them!";

    return FutureBuilder<List<dynamic>>(
      future: Future.value(wikiDetails),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final List<dynamic> wikiDetails = snapshot.data!;
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
                          "insert":
                              '${wikiDetails[index]["details_description"]}\n',
                        },
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
}

class FloatingEditButton extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final Map<String, dynamic> detailMap;
  final String detailType;
  final List<dynamic> wikiDetails;

  const FloatingEditButton({
    Key? key,
    required this.detailType,
    required this.wikiMap,
    required this.detailMap,
    required this.wikiDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeMap = {
      'Character': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditCharacterDetails(
              characterMap: detailMap,
              wikiMap: wikiMap,
            ),
          ),
        );
      },
      'Location': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditLocationDetails(
              locationMap: detailMap,
              wikiMap: wikiMap,
            ),
          ),
        );
      },
      'Section': () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditSectionDetails(
              sectionMap: detailMap,
              wikiMap: wikiMap,
            ),
          ),
        );
      },
    };

    return FloatingActionButton(
      onPressed: routeMap[detailType],
      child: const Icon(Icons.edit),
    );
  }
}
