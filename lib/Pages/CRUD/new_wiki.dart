import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/wiki_list.dart';

class NewWiki extends StatefulWidget {
  const NewWiki({super.key});

  @override
  NewWikiState createState() => NewWikiState();
}

class NewWikiState extends State<NewWiki> {
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
    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setBackgroundColor(lightPurple['200']!);
    quillEditor.setTextColor(text['900']!);
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
          quillEditor.buildEditor(),
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
                    MaterialPageRoute(
                        builder: (context) => const WikiListPage()),
                  );
                });
                dbHandler.createWiki(
                  wiki_name: _titleController.text,
                  section_name: _sectionNamesController.text,
                  wiki_section_count: int.parse(_numSectionsController.text),
                  wiki_description: quillEditor.getDocumentJson().toString(),
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
