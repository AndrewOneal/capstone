import 'package:capstone/Utilities/theme.dart';
import 'package:flutter/material.dart';
import 'package:capstone/main.dart';
import 'package:capstone/Pages/Wiki/wiki_home.dart';

int chapterID = 0;

class WikiSettings extends StatefulWidget {
  final int wikiID;

  const WikiSettings({
    Key? key,
    required this.wikiID,
  }) : super(key: key);

  @override
  WikiSettingsState createState() => WikiSettingsState();
}

class WikiSettingsState extends State<WikiSettings> {
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
      ),
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: Column(
            children: [
              const SizedBox(height: 75),
              _TitleText(wikiTitle: dbHandler.getTitle(id: widget.wikiID)),
              const SizedBox(height: 20),
              _ChapterDropdown(),
              const SizedBox(height: 20),
              _SaveSettingsButton(wikiID: widget.wikiID, chapterID: chapterID),
            ],
          ),
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
            wikiTitle,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.2),
          ),
        ),
        Text(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.2),
        ),
      ],
    );
  }
}

class _ChapterDropdown extends StatefulWidget {
  @override
  _ChapterDropdownState createState() => _ChapterDropdownState();
}

class _ChapterDropdownState extends State<_ChapterDropdown> {
  final List<String> chapters = <String>[
    'Chapter 1',
    'Chapter 2',
    'Chapter 3',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: chapterID,
      isExpanded: true,
      onChanged: (index) {
        setState(() {
          chapterID = index!;
        });
      },
      items: chapters.asMap().entries.map<DropdownMenuItem<int>>((entry) {
        final index = entry.key;
        final value = entry.value;
        return DropdownMenuItem<int>(
          value: index,
          child: Text(value, style: Theme.of(context).textTheme.displayMedium!),
        );
      }).toList(),
    );
  }
}

class _SaveSettingsButton extends StatelessWidget {
  final int wikiID;
  final int chapterID;
  const _SaveSettingsButton({
    Key? key,
    required this.wikiID,
    required this.chapterID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wikiSettingID = chapterID;
    return DarkButton(
      buttonText: "Save Settings",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WikiHome(
                  wikiID: wikiID,
                  wikiTitle: dbHandler.getTitle(id: wikiID),
                  wikiSettingID: wikiSettingID)),
        );
      },
    );
  }
}
