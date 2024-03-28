import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditCharacters extends StatefulWidget {
  final Map<String, dynamic> wikiMap;

  const EditCharacters({
    super.key,
    required this.wikiMap,
  });

  @override
  EditCharactersState createState() => EditCharactersState();
}

class EditCharactersState extends State<EditCharacters> {
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
                const ListTitle(title: "Edit Characters"),
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
  final TextEditingController _characterNameController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;

  _EditCharsForm({
    required this.wikiMap,
  })  : _reasonForEditController = TextEditingController(),
        _characterNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _characterNameController,
            decoration: const InputDecoration(
              labelText: 'Character',
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
