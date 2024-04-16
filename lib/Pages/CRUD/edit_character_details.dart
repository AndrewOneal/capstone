import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditCharacterDetails extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> characterDetailsMap;
  final String characterName;
  final String characterID;
  final int maxSectionNo;

  const EditCharacterDetails({
    super.key,
    required this.wikiMap,
    required this.characterDetailsMap,
    required this.characterName,
    required this.maxSectionNo,
    required this.characterID,
  });

  @override
  EditCharacterDetailsState createState() => EditCharacterDetailsState();
}

class EditCharacterDetailsState extends State<EditCharacterDetails> {
  @override
  Widget build(BuildContext context) {
    final CharacterHandler characterHandler =
        CharacterHandler(characterDetailsMap: widget.characterDetailsMap);
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
                    maxSectionNo: widget.maxSectionNo,
                    characterID: widget.characterID,
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
  final int maxSectionNo;
  final String characterID;

  _EditCharDetailsForm({
    required this.wikiMap,
    required this.characterHandler,
    required this.characterName,
    required this.maxSectionNo,
    required this.characterID,
  }) : _reasonForEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final SectionNoHandler sectionNoHandler = SectionNoHandler();
    sectionNoHandler.setWikiID(wikiID);
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
        String entryID = characterHandler.getEntryID();
        String sectionID = sectionNoHandler.getSectionID();
        String editType =
            entryID.isEmpty ? "createCharacterDetail" : "editCharacterDetail";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "editType": editType,
            "entryID": entryID,
            "characterID": characterID,
            "sectionID": sectionID,
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
        String sectionID = sectionNoHandler.getSectionID();
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
                    "editType": "deleteCharacterDetail",
                    "characterID": characterID,
                    "sectionID": sectionID,
                    "entryID": id,
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
            maxSectionNo: maxSectionNo,
          ),
          quillEditor.buildEditor(),
          TextFormField(
            controller: _reasonForEditController,
            decoration: const InputDecoration(
              labelText: 'Reason for Edit',
            ),
          ),
          largeSizedBox,
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
  final int maxSectionNo;

  const _SectionDropdown(
      {required this.wikiID,
      required this.sectionNoHandler,
      required this.quillEditor,
      required this.characterHandler,
      required this.maxSectionNo});

  @override
  _SectionDropdownState createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<_SectionDropdown> {
  late List<dynamic> sections;
  late int sectionNo = 1;
  late List<Map<String, dynamic>> description = [
    {"insert": "\n"}
  ];

  @override
  void initState() {
    super.initState();
    sections = [];
    description = widget.characterHandler.getDescriptionFromSection(sectionNo);
    widget.quillEditor.setInput(description);
    fetchSections();
    widget.sectionNoHandler.setSectionID();
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

          widget.quillEditor.setInput(description);

          widget.sectionNoHandler.setSectionID();
        });
      },
      items: sections
          .where((section) => section['section_no'] <= widget.maxSectionNo)
          .map<DropdownMenuItem<int>>((section) {
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
  final DBHandler dbHandler = DBHandler();
  late String sectionID = '';
  late String wikiID = '';

  SectionNoHandler();

  int getSectionNo() {
    return sectionNo;
  }

  void setSectionNo(int newSectionNo) {
    sectionNo = newSectionNo;
  }

  Future<void> setSectionID() async {
    sectionID =
        await dbHandler.getSectionID(sectionNo: sectionNo, wikiID: wikiID);
  }

  String getSectionID() {
    return sectionID;
  }

  void setWikiID(String newWikiID) {
    wikiID = newWikiID;
  }
}

class CharacterHandler {
  final List<dynamic> characterDetailsMap;
  Map<String, dynamic> entry = {};

  CharacterHandler({required this.characterDetailsMap});

  void setEntryFromSection(int sectionNo) {
    for (Map<String, dynamic> character in characterDetailsMap) {
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

  List<Map<String, dynamic>> getDescriptionFromSection(int sectionNo) {
    setEntryFromSection(sectionNo);
    if (entry.isNotEmpty) {
      return (entry['details_description']['flutter_quill'] as List)
          .cast<Map<String, dynamic>>();
    }
    return [
      {"insert": "\n"}
    ];
  }

  List<dynamic> getCharacterDetailsMap() {
    return characterDetailsMap;
  }
}
