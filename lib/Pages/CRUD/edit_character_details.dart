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
          child: SingleChildScrollView(
            child: Column(
              children: [
                titleSizedBox,
                const ListTitle(title: "Edit Character Details"),
                SingleChildScrollView(
                  child: _EditCharDetailsForm(
                      wikiMap: widget.wikiMap,
                      characterMap: widget.characterMap),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditCharDetailsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _characterNameController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final Map<String, dynamic> characterMap;

  _EditCharDetailsForm({
    required this.wikiMap,
    required this.characterMap,
  })  : _characterNameController =
            TextEditingController(text: characterMap['name']),
        _reasonForEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final SectionNoHandler sectionNoHandler = SectionNoHandler();
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
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
          _SectionDropdown(wikiID: wikiID, sectionNoHandler: sectionNoHandler),
          quillEditor.buildEditor(),
          TextFormField(
            controller: _reasonForEditController,
            decoration: const InputDecoration(
              labelText: 'Reason for Edit',
            ),
          ),
          mediumSizedBox,
          MediaQuery.of(context).size.width > 514
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DarkButton(
                      buttonText: "Submit For Approval",
                      buttonWidth: MediaQuery.of(context).size.width * 0.4,
                      onPressed: () {
                        // Submit for approval logic
                      },
                    ),
                    DarkButton(
                      buttonText: "Delete Entry",
                      buttonWidth: MediaQuery.of(context).size.width * 0.4,
                      onPressed: () {
                        // Delete entry logic
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    DarkButton(
                      buttonText: "Submit For Approval",
                      buttonWidth: MediaQuery.of(context).size.width * 0.8,
                      onPressed: () {
                        // Submit for approval logic
                      },
                    ),
                    largeSizedBox,
                    DarkButton(
                      buttonText: "Delete Entry",
                      buttonWidth: MediaQuery.of(context).size.width * 0.8,
                      onPressed: () {
                        // Delete entry logic
                      },
                    ),
                  ],
                ),
          extraLargeSizedBox,
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
