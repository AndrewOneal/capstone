import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    DBHandler dbHandler = DBHandler();
    QuillController controller = QuillController.basic();
    controller.document = Document.fromJson(dbHandler.getWikiDescription());
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
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(dbHandler.getWikiDescription().toString()),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: background['500']!,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: SizedBox(
                      height: 400,
                      child: QuillEditor.basic(
                        configurations: QuillEditorConfigurations(
                          padding: const EdgeInsets.all(10),
                          expands: true,
                          controller: controller,
                          readOnly: true,
                          sharedConfigurations: const QuillSharedConfigurations(
                            locale: Locale('en', 'US'),
                          ),
                        ),
                      ),
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
