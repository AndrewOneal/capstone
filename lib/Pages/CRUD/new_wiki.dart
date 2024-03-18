import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:capstone/Pages/CRUD/test.dart';
import 'package:capstone/Utilities/db_util.dart';

class NewWiki extends StatefulWidget {
  const NewWiki({super.key});

  @override
  _NewWikiState createState() => _NewWikiState();
}

class _NewWikiState extends State<NewWiki> {
  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: sideMargins,
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTitle(title: "New Wiki"),
                      SingleChildScrollView(child: _NewWikiForm()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewWikiForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _sectionNamesController = TextEditingController();
  final _numSectionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    DBHandler dbHandler = DBHandler();
    _QuillEditor quillEditor = _QuillEditor();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _sectionNamesController,
            decoration: const InputDecoration(
              labelText: 'Sections Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the names of each section';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _numSectionsController,
            decoration: const InputDecoration(
              labelText: 'Number of Sections',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the number of sections';
              }
              return null;
            },
          ),
          mediumSizedBox,
          quillEditor,
          mediumSizedBox,
          DarkButton(
            buttonText: "Submit Wiki",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(content: Text('Submitting Wiki')),
                    )
                    .closed
                    .then((reason) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TestPage()),
                  );
                });
                dbHandler.addWiki(
                  title: _titleController.text,
                  sectionsName: _sectionNamesController.text,
                  wiki_section_count: int.parse(_numSectionsController.text),
                  description: quillEditor.getDocumentJson(),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill out all fields')),
                );
              }
            },
          ),
          largeSizedBox,
        ],
      ),
    );
  }
}

class _QuillEditor extends StatelessWidget {
  final QuillController _quillController = QuillController.basic();

  List<Map<String, dynamic>> getDocumentJson() {
    return _quillController.document.toDelta().toJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: background['500']!,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: _quillController,
            showFontFamily: false,
            showInlineCode: false,
            showAlignmentButtons: true,
            showJustifyAlignment: false,
            showCodeBlock: false,
            showHeaderStyle: false,
            showSearchButton: false,
            showListCheck: false,
            fontSizesValues: const <String, String>{
              'Small': '18',
              'Medium': '24',
              'Large': '32',
              'Ex Large': '40',
            },
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('en', 'US'),
            ),
          ),
        ),
        const Divider(),
        SizedBox(
          height: 400,
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              padding: const EdgeInsets.all(10),
              expands: true,
              controller: _quillController,
              readOnly: false,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('en', 'US'),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
