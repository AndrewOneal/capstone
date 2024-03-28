import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Pages/Account/login.dart';
import 'package:capstone/Pages/Account/wiki_settings.dart';
import 'package:capstone/Pages/Wiki/wiki_characters.dart';
import 'package:capstone/Pages/Wiki/wiki_sections.dart';
import 'package:capstone/Pages/Wiki/wiki_locations.dart';
import 'package:capstone/Pages/Account/account.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/CRUD/edit_wiki.dart';

class WikiHome extends StatefulWidget {
  final Map<String, dynamic> wikiMap;

  const WikiHome({
    super.key,
    required this.wikiMap,
  });

  @override
  WikiHomeState createState() => WikiHomeState();
}

class WikiHomeState extends State<WikiHome> {
  late int sectionNo = 0;

  @override
  void initState() {
    super.initState();
    _updateSectionNo();
  }

  Future<void> _updateSectionNo() async {
    final CacheManager cacheManager = CacheManager();
    final String wikiID = widget.wikiMap['id'];
    final isInCache = await cacheManager.isWikiIDInCache(wikiID);

    if (isInCache) {
      final newSectionNo = await cacheManager.getSectionNo(wikiID);
      setState(() {
        sectionNo = newSectionNo;
      });
    } else {
      await cacheManager.addToCache(wikiID, 1);
      setState(() {
        sectionNo = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String wikiTitle = widget.wikiMap['wiki_name'];
    final String wikiDescription = widget.wikiMap['wiki_description'];
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox titleSizedBox = global.titleSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const WikiListPage()),
            );
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
                          wikiMap: widget.wikiMap, sectionNo: sectionNo)),
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleSizedBox,
                _TitleText(wikiTitle: wikiTitle),
                largeSizedBox,
                SingleChildScrollView(
                  child: _WikiCard(wikiDescription: wikiDescription),
                ),
                largeSizedBox,
                SingleChildScrollView(
                  child: _ButtonList(
                      wikiMap: widget.wikiMap, sectionNo: sectionNo),
                ),
              ],
            ),
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
                      builder: (context) => EditWiki(
                        wikiMap: widget.wikiMap,
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

class _TitleText extends StatelessWidget {
  final String wikiTitle;

  const _TitleText({required this.wikiTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Welcome to the',
            style: TextStyles.whiteHeader.copyWith(height: 1.2),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            wikiTitle,
            style: TextStyles.purpleHeader.copyWith(height: 1.2),
          ),
        ),
        Text(
          'Wikipedia',
          style: TextStyles.whiteHeader.copyWith(height: 1.2),
        ),
      ],
    );
  }
}

class _WikiCard extends StatelessWidget {
  final String wikiDescription;
  final cardPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 20);

  const _WikiCard({required this.wikiDescription});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Center(
              child: DefaultQuillRead(input: [
                {
                  "insert": wikiDescription,
                  "attributes": {"color": "#FF363942"}
                },
                {
                  "insert": "\n",
                }
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonList extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;

  const _ButtonList({required this.sectionNo, required this.wikiMap});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> buttonRoutes = {
      'Sections': WikiSectionsPage(
        wikiMap: wikiMap,
        sectionNo: sectionNo,
      ),
      'Characters': WikiCharactersPage(wikiMap: wikiMap, sectionNo: sectionNo),
      'Locations': WikiLocationsPage(wikiMap: wikiMap, sectionNo: sectionNo),
    };

    return SizedBox(
      height: 200,
      child: ListView.separated(
        itemCount: buttonRoutes.length,
        separatorBuilder: (BuildContext context, int index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(),
        ),
        itemBuilder: (BuildContext context, int index) {
          final buttonText = buttonRoutes.keys.elementAt(index);
          final route = buttonRoutes.values.elementAt(index);

          return LightPurpleButton1(
            buttonText: buttonText,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => route),
              );
            },
          );
        },
      ),
    );
  }
}
