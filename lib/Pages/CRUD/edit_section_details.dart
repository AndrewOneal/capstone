import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditSectionDetails extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> sectionMap;
  final String sectionName;
  final String sectionID;

  const EditSectionDetails({
    super.key,
    required this.wikiMap,
    required this.sectionMap,
    required this.sectionName,
    required this.sectionID,
  });

  @override
  EditSectionDetailsState createState() => EditSectionDetailsState();
}

class EditSectionDetailsState extends State<EditSectionDetails> {
  @override
  Widget build(BuildContext context) {
    final SectionHandler sectionHandler = SectionHandler();
    widget.sectionMap.isNotEmpty
        ? sectionHandler.setEntry(widget.sectionMap[0])
        : {};
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
                    firstLineText: "Edit Section Details",
                    secondLineText: widget.sectionName,
                    height: 200),
                SingleChildScrollView(
                  child: _EditSectionDetailsForm(
                    wikiMap: widget.wikiMap,
                    sectionHandler: sectionHandler,
                    sectionName: widget.sectionName,
                    sectionID: widget.sectionID,
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

class _EditSectionDetailsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final SectionHandler sectionHandler;
  final String sectionName;
  final String sectionID;

  _EditSectionDetailsForm({
    required this.wikiMap,
    required this.sectionHandler,
    required this.sectionName,
    required this.sectionID,
  }) : _reasonForEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setInput(sectionHandler.getDescription());
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
        String entryID = sectionHandler.getEntryID();
        String editType =
            entryID.isEmpty ? "createSectionDetail" : "editSectionDetail";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "editType": editType,
            "sectionID": sectionID,
            "entryID": entryID,
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
        String entryID = sectionHandler.getEntryID();
        entryID.isEmpty
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
                    "editType": "deleteSectionDetail",
                    "sectionID": sectionID,
                    "entryID": entryID,
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

class SectionHandler {
  Map<String, dynamic> entry = {};

  SectionHandler();

  String getEntryID() {
    if (entry.isNotEmpty) {
      return entry['id'];
    }
    return '';
  }

  List<Map<String, dynamic>> getDescription() {
    if (entry.isNotEmpty) {
      return (entry['details_description']['flutter_quill'] as List)
          .cast<Map<String, dynamic>>();
    }
    return [
      {"insert": "\n"}
    ];
  }

  void setEntry(Map<String, dynamic> entry) {
    this.entry = entry;
  }
}
