import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class APIListPage extends StatelessWidget {
  const APIListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _APIList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _APIList extends StatelessWidget {
  const _APIList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTitle(title: "Wikis"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler().getWikis(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Sections"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler().getSections(wikiID: "ndlh8nkyr4uyjw4"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Characters"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler().getCharacters(wikiID: "ndlh8nkyr4uyjw4"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Locations"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler().getLocations(wikiID: "ndlh8nkyr4uyjw4"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Character Details"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler().getCharacterDetails(
              characterID: "nbxynzck218e4qq", section_no: 3),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Section Details"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler()
              .getSectionDetails(section_no: 3, wiki_id: "ndlh8nkyr4uyjw4"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Location Details"),
        FutureBuilder<List<dynamic>>(
          future: DBHandler()
              .getLocationDetails(section_no: 3, locationID: "9cu0atfmbsvi1di"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTitle(title: "Cache"),
        FutureBuilder<Map<String, dynamic>>(
          future: CacheManager().getCache(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DefaultQuillRead(
                input: [
                  {
                    "insert": snapshot.data?.toString(),
                  },
                  {
                    "insert": '\n',
                  }
                ],
              );
            }
          },
        ),
      ],
    );
  }
}