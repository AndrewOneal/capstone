import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditWiki extends StatelessWidget {
  final Map<String, dynamic> wikiMap;

  const EditWiki({super.key, required this.wikiMap});
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
                const ListTitle(title: "Edit Wiki Details"),
                SingleChildScrollView(
                  child: _EditWikiForm(wikiMap: wikiMap),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditWikiForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonForEditController =
      TextEditingController();
  final TextEditingController _wikiNameController;
  final Map<String, dynamic> wikiMap;
  final QuillEditorManager quillEditor = QuillEditorManager();

  _EditWikiForm({
    required this.wikiMap,
  }) : _wikiNameController = TextEditingController(text: wikiMap['wiki_name']);

  @override
  Widget build(BuildContext context) {
    quillEditor.setInput([
      {
        "insert": wikiMap['wiki_description'],
        "attributes": {"color": "#FF363942"}
      },
      {
        "insert": "\n",
      }
    ]);
    quillEditor.setBackgroundColor(lightPurple['200']!);
    quillEditor.setTextColor(text['900']!);
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final DBHandler dbHandler = DBHandler();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _wikiNameController,
            decoration: const InputDecoration(
              labelText: 'Wiki Name',
            ),
          ),
          mediumSizedBox,
          quillEditor.buildEditor(),
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
