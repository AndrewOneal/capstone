import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:flutter_quill/flutter_quill.dart';

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
  final _numCharactersController = TextEditingController();
  final _numLocationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final SizedBox largeSizedBox = global.largeSizedBox;
    DBHandler dbHandler = DBHandler();
    return Form(
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
          TextFormField(
            controller: _numCharactersController,
            decoration: const InputDecoration(
              labelText: 'Number of Characters',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the number of characters';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _numLocationsController,
            decoration: const InputDecoration(
              labelText: 'Number of Locations',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the number of locations';
              }
              return null;
            },
          ),
          mediumSizedBox,
          _QuillEditor(),
          mediumSizedBox,
          DarkButton(
            buttonText: "Submit Wiki",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                dbHandler.addWiki(
                  title: _titleController.text,
                  sectionsName: _sectionNamesController.text,
                  numSections: int.parse(_numSectionsController.text),
                  numCharacters: int.parse(_numCharactersController.text),
                  numLocations: int.parse(_numLocationsController.text),
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
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      QuillToolbar.simple(
        configurations: QuillSimpleToolbarConfigurations(
          controller: _controller,
          sharedConfigurations: const QuillSharedConfigurations(
            locale: Locale('en', 'US'),
          ),
        ),
      ),
      SizedBox(
        height: 400,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: background['500']!,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              controller: _controller,
              readOnly: false,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('en', 'US'),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
