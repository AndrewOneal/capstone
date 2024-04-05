import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditWiki extends StatefulWidget {
  final Map<String, dynamic> wikiMap;

  const EditWiki({
    super.key,
    required this.wikiMap,
  });

  @override
  EditWikiState createState() => EditWikiState();
}

class EditWikiState extends State<EditWiki> {
  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final String wikiTitle = widget.wikiMap['wiki_name'];
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
                    firstLineText: "Edit Wiki Details",
                    secondLineText: wikiTitle,
                    height: 200),
                SingleChildScrollView(
                  child: _EditWikiDetailsForm(
                    wikiMap: widget.wikiMap,
                    wikiTitle: wikiTitle,
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

class _EditWikiDetailsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wikiTitleController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final String wikiTitle;

  _EditWikiDetailsForm({
    required this.wikiMap,
    required this.wikiTitle,
  })  : _reasonForEditController = TextEditingController(),
        _wikiTitleController = TextEditingController(text: wikiTitle);

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final wikiDescription = wikiMap['wiki_description'];
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setBackgroundColor(lightPurple['200']!);
    quillEditor.setTextColor(text['900']!);
    quillEditor.setInput([
      {
        "insert": '$wikiDescription\n',
      },
    ]);
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
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "edit_type": "editWiki",
            "updatedEntry": quillEditor.getDocumentJson(),
            "reason": _reasonForEditController.text,
          },
        );
      },
    );

    final Widget deleteButton = DarkButton(
      buttonText: "Delete Wiki",
      buttonWidth: buttonWidth,
      onPressed: () {
        {
          ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(
                    content: Text("Submitting Request"),
                    duration: Duration(seconds: 1)),
              )
              .closed
              .then((reason) {
            Navigator.pop(context);
          });
          dbHandler.createVerificationRequest(
            submitterUserID: pb.authStore.model.id,
            wikiID: wikiID,
            requestPackage: {
              "edit_type": "deleteWiki",
              "reason": _reasonForEditController.text,
            },
          );
        }
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _wikiTitleController,
            decoration: const InputDecoration(
              labelText: 'Wiki Title',
            ),
          ),
          mediumSizedBox,
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
