import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditSections extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> sectionsMap;

  const EditSections({
    super.key,
    required this.wikiMap,
    required this.sectionsMap,
  });

  @override
  EditSectionsState createState() => EditSectionsState();
}

class EditSectionsState extends State<EditSections> {
  @override
  Widget build(BuildContext context) {
    final SectionHandler sectionHandler =
        SectionHandler(sectionsMap: widget.sectionsMap);
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
                const ListTitle(title: 'Edit Sections'),
                SingleChildScrollView(
                  child: _EditCharForm(
                    wikiMap: widget.wikiMap,
                    sectionHandler: sectionHandler,
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

class _EditCharForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final SectionHandler sectionHandler;

  _EditCharForm({
    required this.wikiMap,
    required this.sectionHandler,
  })  : _reasonForEditController = TextEditingController(),
        nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final DBHandler dbHandler = DBHandler();
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
        String sectionID = sectionHandler.getSectionID();
        String editType = sectionID.isEmpty ? "createSection" : "editSection";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "editType": editType,
            "sectionID": sectionID,
            "name": nameController.text,
            "reason": _reasonForEditController.text,
          },
        );
      },
    );

    final Widget deleteButton = DarkButton(
      buttonText: "Delete Section",
      buttonWidth: buttonWidth,
      onPressed: () {
        String sectionID = sectionHandler.getSectionID();
        sectionID.isEmpty
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
                    "editType": "deleteSection",
                    "sectionID": sectionID,
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
            sectionHandler: sectionHandler,
            nameController: nameController,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
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
  final SectionHandler sectionHandler;
  final TextEditingController nameController;

  const _SectionDropdown(
      {required this.wikiID,
      required this.sectionHandler,
      required this.nameController});

  @override
  _SectionDropdownState createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<_SectionDropdown> {
  late List<dynamic> sections;
  late String id = '';
  late String name = '';

  @override
  void initState() {
    super.initState();
    id = widget.sectionHandler.getSectionID();
    name = widget.sectionHandler.getNameFromID(id);
    sections = widget.sectionHandler.getSectionMap();
    widget.nameController.text = name;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: id,
      isExpanded: true,
      onChanged: (index) {
        setState(() {
          id = index!;
          name = widget.sectionHandler.getNameFromID(id);
          widget.nameController.text = name;
        });
      },
      items: [
        ...sections.map<DropdownMenuItem<String>>((section) {
          final sectionID = section['id'];
          final sectionName = section['section_name'];
          return DropdownMenuItem<String>(
            value: sectionID,
            child: Text(sectionName, style: TextStyles.listText),
          );
        }),
        DropdownMenuItem<String>(
          value: 'CREATEASECTION',
          child: Text('Create a Section', style: TextStyles.listText),
        ),
      ],
    );
  }
}

class SectionHandler {
  final List<dynamic> sectionsMap;
  Map<String, dynamic> entry = {};

  SectionHandler({required this.sectionsMap}) : entry = sectionsMap[0] ?? {};

  void setEntryFromID(String sectionID) {
    for (Map<String, dynamic> section in sectionsMap) {
      final entryID = section['id'].toString();
      if (entryID.contains(sectionID)) {
        entry = section;
        return;
      }
    }
    entry = {};
    return;
  }

  String getSectionID() {
    if (entry.isNotEmpty) {
      return entry['id'];
    }
    return '';
  }

  String getNameFromID(String id) {
    setEntryFromID(id);
    if (entry.isNotEmpty) {
      return entry['section_name'];
    }
    return '';
  }

  List<dynamic> getSectionMap() {
    return sectionsMap;
  }
}
