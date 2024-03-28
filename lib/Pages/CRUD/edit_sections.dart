import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditSections extends StatefulWidget {
  final Map<String, dynamic> wikiMap;

  const EditSections({
    super.key,
    required this.wikiMap,
  });

  @override
  EditSectionsState createState() => EditSectionsState();
}

class EditSectionsState extends State<EditSections> {
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
                const ListTitle(title: "Edit Sections"),
                SingleChildScrollView(
                  child: _EditCharsForm(wikiMap: widget.wikiMap),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditCharsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sectionNameController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;

  _EditCharsForm({
    required this.wikiMap,
  })  : _reasonForEditController = TextEditingController(),
        _sectionNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
    SectionNoHandler sectionNoHandler = SectionNoHandler();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _SectionDropdown(
            wikiID: wikiMap['id'],
            sectionNoHandler: sectionNoHandler,
          ),
          mediumSizedBox,
          TextFormField(
            controller: _sectionNameController,
            decoration: const InputDecoration(
              labelText: 'Section',
            ),
          ),
          mediumSizedBox,
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
