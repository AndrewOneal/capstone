import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditCharacterDetails extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final Map<String, dynamic> characterMap;

  const EditCharacterDetails({
    super.key,
    required this.wikiMap,
    required this.characterMap,
  });

  @override
  EditCharacterDetailsState createState() => EditCharacterDetailsState();
}

class EditCharacterDetailsState extends State<EditCharacterDetails> {
  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox titleSizedBox = global.titleSizedBox;
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
              const ListTitle(title: "Edit Character Details"),
              SingleChildScrollView(
                child: _EditCharDetailsForm(
                    wikiMap: widget.wikiMap, characterMap: widget.characterMap),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditCharDetailsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _characterNameController;
  final TextEditingController _sectionSummaryController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final Map<String, dynamic> characterMap;

  _EditCharDetailsForm({
    required this.wikiMap,
    required this.characterMap,
  })  : _characterNameController =
            TextEditingController(text: characterMap['name']),
        _sectionSummaryController = TextEditingController(),
        _reasonForEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    final wikiID = wikiMap['id'];
    final SectionNoHandler sectionNoHandler = SectionNoHandler();
    final DBHandler dbHandler = DBHandler();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _characterNameController,
            decoration: const InputDecoration(
              labelText: 'Character Name',
            ),
          ),
          mediumSizedBox,
          _SectionDropdown(wikiID: wikiID, sectionNoHandler: sectionNoHandler),
          mediumSizedBox,
          TextFormField(
            controller: _sectionSummaryController,
            decoration: const InputDecoration(
              labelText: 'Section Summary',
            ),
            maxLines: 5,
          ),
          mediumSizedBox,
          TextFormField(
            controller: _reasonForEditController,
            decoration: const InputDecoration(
              labelText: 'Reason for Edit',
            ),
            maxLines: 5,
          ),
          mediumSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DarkButton(
                buttonText: "Submit For Approval",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          const SnackBar(content: Text('Submitting Edit')),
                        )
                        .closed
                        .then((reason) {
                      Navigator.pop(
                        context,
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill out all fields')),
                    );
                  }
                },
              ),
              DarkButton(
                buttonText: "Delete Entry",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          const SnackBar(
                              content: Text('Submitting Delete Request')),
                        )
                        .closed
                        .then((reason) {
                      Navigator.pop(
                        context,
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fill out all required fields')),
                    );
                  }
                },
              ),
            ],
          ),
          largeSizedBox,
        ],
      ),
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

class SectionNoHandler {
  late int sectionNo = 1;

  SectionNoHandler();

  int getSectionNo() {
    return sectionNo;
  }

  void setSectionNo(int newSectionNo) {
    sectionNo = newSectionNo;
  }
}
