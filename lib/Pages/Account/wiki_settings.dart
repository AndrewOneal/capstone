import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Wiki/wiki_home.dart';
import 'package:capstone/Utilities/db_util.dart';

class WikiSettings extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final int sectionNo;

  const WikiSettings({
    Key? key,
    required this.wikiMap,
    required this.sectionNo,
  }) : super(key: key);

  @override
  WikiSettingsState createState() => WikiSettingsState();
}

class WikiSettingsState extends State<WikiSettings> {
  final SectionNoHandler sectionNoHandler = SectionNoHandler();

  @override
  void initState() {
    super.initState();
    sectionNoHandler.setSectionNo(widget.sectionNo);
  }

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox titleSizedBox = global.titleSizedBox;
    final SizedBox mediumSizedBox = global.mediumSizedBox;
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
              titleSizedBox,
              _TitleText(wikiTitle: widget.wikiMap['wiki_name']),
              mediumSizedBox,
              _SectionDropdown(
                  wikiID: widget.wikiMap['id'],
                  sectionNoHandler: sectionNoHandler),
              mediumSizedBox,
              _SaveSettingsButton(
                  wikiMap: widget.wikiMap, sectionNoHandler: sectionNoHandler),
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
            style: TextStyles.purpleHeader.copyWith(height: 1.2),
          ),
        ),
        Text(
          'Settings',
          style: TextStyles.whiteHeader.copyWith(height: 1.2),
        ),
      ],
    );
  }
}

class _SectionDropdown extends StatefulWidget {
  final String wikiID;
  final SectionNoHandler sectionNoHandler;

  const _SectionDropdown(
      {required this.wikiID, required this.sectionNoHandler});

  @override
  _SectionDropdownState createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<_SectionDropdown> {
  late List<dynamic> sections;
  late int sectionNo;

  @override
  void initState() {
    super.initState();
    sections = [];
    sectionNo = widget.sectionNoHandler.getSectionNo();
    fetchSections();
  }

  Future<void> fetchSections() async {
    DBHandler dbHandler = DBHandler();
    List fetchedSections = await dbHandler.getSections(wikiID: widget.wikiID);
    setState(() {
      sections = fetchedSections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: sectionNo,
      isExpanded: true,
      onChanged: (index) {
        setState(() {
          sectionNo = index!;
          widget.sectionNoHandler.setSectionNo(sectionNo);
        });
      },
      items: sections.map<DropdownMenuItem<int>>((section) {
        final sectionNo = section['section_no'];
        final sectionName = section['section_name'];
        return DropdownMenuItem<int>(
          value: sectionNo,
          child: Text(sectionName, style: TextStyles.listText),
        );
      }).toList(),
    );
  }
}

class _SaveSettingsButton extends StatelessWidget {
  final Map<String, dynamic> wikiMap;
  final SectionNoHandler sectionNoHandler;

  const _SaveSettingsButton({
    Key? key,
    required this.wikiMap,
    required this.sectionNoHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkButton(
      buttonText: "Save Settings",
      onPressed: () {
        final String wikiID = wikiMap['id'];
        final int sectionNo = sectionNoHandler.getSectionNo();

        CacheManager cacheManager = CacheManager();
        cacheManager.updateExistingEntry(wikiID, sectionNo);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WikiHome(wikiMap: wikiMap)),
        );
      },
    );
  }
}

class SectionNoHandler {
  late int sectionNo;

  SectionNoHandler();

  int getSectionNo() {
    return sectionNo;
  }

  void setSectionNo(int newSectionNo) {
    sectionNo = newSectionNo;
  }
}
