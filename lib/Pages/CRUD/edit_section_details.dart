import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditSectionDetails extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final Map<String, dynamic> sectionMap;

  const EditSectionDetails({
    super.key,
    required this.wikiMap,
    required this.sectionMap,
  });

  @override
  EditSectionDetailsState createState() => EditSectionDetailsState();
}

class EditSectionDetailsState extends State<EditSectionDetails> {
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
                      wikiMap: widget.wikiMap, sectionMap: widget.sectionMap),
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
  final TextEditingController _sectionNameController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final Map<String, dynamic> sectionMap;

  _EditCharDetailsForm({
    required this.wikiMap,
    required this.sectionMap,
  })  : _sectionNameController =
            TextEditingController(text: sectionMap['name']),
        _reasonForEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _sectionNameController,
            decoration: const InputDecoration(
              labelText: 'Section Name',
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
          DarkButton(
            buttonText: "Submit For Approval",
            buttonWidth: MediaQuery.of(context).size.width * 0.8,
            onPressed: () {
              // Submit for approval logic
            },
          ),
          extraLargeSizedBox,
        ],
      ),
    );
  }
}
