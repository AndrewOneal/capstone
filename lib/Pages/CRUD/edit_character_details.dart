import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditCharacterDetails extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> characterMap;
  final String characterName;

  const EditCharacterDetails({
    super.key,
    required this.wikiMap,
    required this.characterMap,
    required this.characterName,
  });

  @override
  EditCharacterDetailsState createState() => EditCharacterDetailsState();
}

class EditCharacterDetailsState extends State<EditCharacterDetails> {
  @override
  Widget build(BuildContext context) {
    final CharacterHandler characterHandler =
        CharacterHandler(characterMap: widget.characterMap);
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
      ),
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TwoLineTitle(
                    firstLineText: "Edit Character Details",
                    secondLineText: widget.characterName,
                    height: 200),
                SingleChildScrollView(
                  child: _EditCharDetailsForm(
                    wikiMap: widget.wikiMap,
                    characterHandler: characterHandler,
                    characterName: widget.characterName,
                  ),
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
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final CharacterHandler characterHandler;
  final String characterName;

  _EditCharDetailsForm({
    required this.wikiMap,
    required this.characterHandler,
    required this.characterName,
  }) : _reasonForEditController = TextEditingController();

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
    final double buttonWidth = MediaQuery.of(context).size.width > 514
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.8;

    final Widget submitButton = DarkButton(
      buttonText: "Submit For Approval",
      buttonWidth: buttonWidth,
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              const SnackBar(
                  content: Text('Submitting Request'),
                  duration: Duration(seconds: 1)),
            )
            .closed
            .then((reason) {
          Navigator.pop(context);
        });
        String id = characterHandler.getEntryID();
        String editType =
            id == '' ? "createCharacterDetail" : "editCharacterDetail";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "edit_type": editType,
            "id": id,
            "updatedEntry": quillEditor.getDocumentJson(),
            "reason": _reasonForEditController.text,
          },
        );
      },
    );

    final Widget deleteButton = DarkButton(
      buttonText: "Delete Entry",
      buttonWidth: buttonWidth,
      onPressed: () {
        String id = characterHandler.getEntryID();
        id.isEmpty
            ? {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text("Can't delete an entry that does not exist"),
                      duration: Duration(seconds: 1)),
                )
              }
            : {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(
                          content: Text("Submitting Request"),
                          duration: Duration(seconds: 1)),
                    )
                    .closed
                    .then((reason) {
                  Navigator.pop(context);
                }),
                dbHandler.createVerificationRequest(
                  submitterUserID: pb.authStore.model.id,
                  wikiID: wikiID,
                  requestPackage: {
                    "edit_type": "deleteCharacterDetail",
                    "id": id,
                    "reason": _reasonForEditController.text,
                  },
                ),
              };
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _SectionDropdown(
            wikiID: wikiID,
            sectionNoHandler: sectionNoHandler,
            quillEditor: quillEditor,
            characterHandler: characterHandler,
          ),
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
                    submitButton,
                    deleteButton,
                  ],
                )
              : Column(
                  children: [
                    submitButton,
                    largeSizedBox,
                    deleteButton,
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
  final QuillEditorManager quillEditor;
  final CharacterHandler characterHandler;

  const _SectionDropdown(
      {required this.wikiID,
      required this.sectionNoHandler,
      required this.quillEditor,
      required this.characterHandler});

  @override
  _SectionDropdownState createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<_SectionDropdown> {
  late List<dynamic> sections;
  late int sectionNo = 1;
  late String description = '';

  @override
  void initState() {
    super.initState();
    sections = [];
    description = widget.characterHandler.getDescriptionFromSection(sectionNo);
    widget.quillEditor.setInput([
      {
        "insert": '$description\n',
      },
    ]);
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

          description =
              widget.characterHandler.getDescriptionFromSection(sectionNo);

          widget.quillEditor.setInput([
            {
              "insert": '$description\n',
            },
          ]);
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

class CharacterHandler {
  final List<dynamic> characterMap;
  Map<String, dynamic> entry = {};

  CharacterHandler({required this.characterMap});

  void setEntryFromSection(int sectionNo) {
    for (Map<String, dynamic> character in characterMap) {
      final characterSectionNo =
          int.tryParse(character['section_no'].toString());
      if (characterSectionNo == sectionNo) {
        entry = character;
        return;
      }
    }
    entry = {};
    return;
  }

  String getEntryID() {
    if (entry.isNotEmpty) {
      return entry['id'];
    }
    return '';
  }

  String getDescriptionFromSection(int sectionNo) {
    setEntryFromSection(sectionNo);
    if (entry.isNotEmpty) {
      return entry['details_description'];
    }
    return '';
  }

  List<dynamic> getCharacterMap() {
    return characterMap;
  }
}
