import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';
import 'package:capstone/Pages/Wiki/wiki_details.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Account/account.dart';
import 'package:capstone/Pages/CRUD/edit_locations.dart';

class WikiLocationsPage extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;

  const WikiLocationsPage({
    super.key,
    required this.wikiMap,
    required this.sectionNo,
  });

  @override
  State<WikiLocationsPage> createState() => _WikiLocationsPageState();
}

class _WikiLocationsPageState extends State<WikiLocationsPage> {
  late List<dynamic> locationsMap = [];

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    final dbHandler = DBHandler();
    final details = await dbHandler.getLocations(wikiID: widget.wikiMap['id']);
    setState(() {
      locationsMap = details;
    });
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
                          sectionNo: widget.sectionNo)),
                );
              }),
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
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const ListTitle(title: "Locations"),
                  Expanded(
                    child: _LocationList(
                        wikiMap: widget.wikiMap, sectionNo: widget.sectionNo),
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
                    MaterialPageRoute(
                      builder: (context) => EditLocations(
                        wikiMap: widget.wikiMap,
                        locationsMap: locationsMap,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.edit),
              ),
            )
          : null,
    );
  }
}

class _LocationList extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;
  const _LocationList({required this.wikiMap, required this.sectionNo});

  @override
  Widget build(BuildContext context) {
    final String wikiID = wikiMap['id'];
    DBHandler dbHandler = DBHandler();
    String disclaimerText = pb.authStore.isValid
        ? "Don't see the location you're looking for? Hit the edit button to add them!"
        : "Don't see the location you're looking for? Login or create an account to add them!";
    return FutureBuilder<List<dynamic>>(
      future: dbHandler.getLocations(wikiID: wikiID),
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
          List<dynamic> wikiLocations = snapshot.data!;
          return ListView.separated(
            itemCount: wikiLocations.length + 1,
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(),
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index == wikiLocations.length) {
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
                        buttonText: wikiLocations[index]['name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WikiDetailsPage(
                                wikiMap: wikiMap,
                                sectionNo: sectionNo,
                                detailName: wikiLocations[index]['name'],
                                detailType: 'Location',
                                detailMap: wikiLocations[index],
                              ),
                            ),
                          );
                        },
                      )
                    : LightPurpleButton1(
                        buttonText: wikiLocations[index]['name'],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WikiDetailsPage(
                                wikiMap: wikiMap,
                                sectionNo: sectionNo,
                                detailName: wikiLocations[index]['name'],
                                detailType: 'Location',
                                detailMap: wikiLocations[index],
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
