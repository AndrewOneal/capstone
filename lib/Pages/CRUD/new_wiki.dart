import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';

class NewWiki extends StatefulWidget {
  const NewWiki({super.key});

  @override
  _NewWikiState createState() => _NewWikiState();
}

class _NewWikiState extends State<NewWiki> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const ListTitle(title: "Characters"),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
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
