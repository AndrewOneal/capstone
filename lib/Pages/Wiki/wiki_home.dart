import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Pages/Account/login.dart';
import '../Account/wiki_settings.dart';
import 'wiki_characters.dart';
import 'wiki_sections.dart';
import 'wiki_locations.dart';

class WikiHome extends StatefulWidget {
  final int wikiID;
  final String wikiTitle;
  final int? wikiSettingID;

  const WikiHome(
      {Key? key,
      required this.wikiID,
      required this.wikiTitle,
      this.wikiSettingID = 0})
      : super(key: key);

  @override
  WikiHomeState createState() => WikiHomeState();
}

class WikiHomeState extends State<WikiHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
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
                      builder: (context) =>
                          WikiSettings(wikiID: widget.wikiID)),
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
          child: Column(
            children: [
              titleSizedBox,
              _TitleText(wikiTitle: widget.wikiTitle),
              const SizedBox(height: 40),
              _WikiCard(wikiID: widget.wikiID, wikiTitle: widget.wikiTitle),
              const SizedBox(height: 40),
              _ButtonList(
                  wikiID: widget.wikiID, wikiSettingsID: widget.wikiSettingID!),
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
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.2),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            wikiTitle,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
          ),
        ),
        Text(
          'Wikipedia',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.2),
        ),
      ],
    );
  }
}

class _WikiCard extends StatelessWidget {
  final int wikiID;
  final String wikiTitle;
  final cardPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 20);

  const _WikiCard({required this.wikiID, required this.wikiTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Center(
              child: Text(
                dbHandler.getDescription(id: wikiID),
                style: Theme.of(context).textTheme.bodyMedium!,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonList extends StatelessWidget {
  final int wikiID;
  final int wikiSettingsID;

  const _ButtonList({required this.wikiID, required this.wikiSettingsID});

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> buttonRoutes = {
      'Sections':
          WikiSectionsPage(wikiID: wikiID, wikiSettingID: wikiSettingsID),
      'Characters':
          WikiCharactersPage(wikiID: wikiID, wikiSettingID: wikiSettingsID),
      'Locations':
          WikiLocationsPage(wikiID: wikiID, wikiSettingID: wikiSettingsID),
    };

    return SizedBox(
      height: 300,
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