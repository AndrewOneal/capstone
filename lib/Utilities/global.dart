import 'package:flutter/material.dart';
import 'package:capstone/Utilities/theme.dart';
export 'package:capstone/Utilities/theme.dart';
export 'package:capstone/main.dart';
export 'package:capstone/Utilities/buttons.dart';
import 'package:flutter_quill/flutter_quill.dart';
export 'package:capstone/Utilities/cache.dart';

class Global {
  static final Global _instance = Global._internal();

  factory Global() {
    return _instance;
  }

  Global._internal();

  EdgeInsets sideMargins = const EdgeInsets.symmetric(horizontal: 25);
  SizedBox titleSizedBox = const SizedBox(height: 60);
  SizedBox smallSizedBox = const SizedBox(height: 10);
  SizedBox mediumSizedBox = const SizedBox(height: 20);
  SizedBox largeSizedBox = const SizedBox(height: 40);
  SizedBox extraLargeSizedBox = const SizedBox(height: 60);
  String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac odio vel purus molestie posuere. Curabitur non ante felis. Fusce volutpat turpis quis velit commodo, a tristique elit tempor. Etiam pulvinar augue ut est consectetur, in volutpat sem varius. Sed id dapibus odio. Cras ullamcorper leo quis hendrerit facilisis. Vivamus in risus euismod, pharetra elit eu, gravida lorem. Etiam dictum efficitur nulla sit amet egestas. Praesent vel mi rhoncus, gravida neque eu, elementum lorem. Integer vulputate quam nec nunc luctus aliquet. Etiam lacinia fringilla purus, vel interdum ligula aliquet vel. Mauris a lorem tempor, fermentum mauris eu, convallis lorem. Vivamus aliquet erat in laoreet efficitur. Aenean nec suscipit mi, non molestie risus. Nulla in leo at lorem porta tristique.";
}

class ListTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const ListTitle({super.key, required this.title, this.fontSize = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: background['default'],
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyles.whiteHeader.copyWith(fontSize: fontSize),
        ),
      ),
    );
  }
}

class DefaultQuillRead extends StatelessWidget {
  final List<Map<String, dynamic>> input;

  const DefaultQuillRead({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    QuillController quillController = QuillController.basic();
    quillController.document = Document.fromJson(input);
    return QuillEditor.basic(
      configurations: QuillEditorConfigurations(
        padding: const EdgeInsets.all(10),
        controller: quillController,
        readOnly: true,
        showCursor: false,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en', 'US'),
        ),
      ),
    );
  }
}

class QuillEditorManager {
  final QuillController _quillController = QuillController.basic();
  Color backgroundColor = background['default']!;
  Color textColor = text['default']!;

  void setInput(List<Map<String, dynamic>> input) {
    _quillController.document = Document.fromJson(input);
  }

  void setBackgroundColor(Color color) {
    backgroundColor = color;
  }

  void setTextColor(Color color) {
    textColor = color;
  }

  List<Map<String, dynamic>> getDocumentJson() {
    return _quillController.document.toDelta().toJson();
  }

  Widget buildRead() {
    return QuillEditor.basic(
      configurations: QuillEditorConfigurations(
        padding: const EdgeInsets.all(10),
        controller: _quillController,
        readOnly: true,
        showCursor: false,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en', 'US'),
        ),
      ),
    );
  }

  Widget buildEditor() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: background['500']!,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
            child: Container(
              color: backgroundColor,
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  padding: const EdgeInsets.all(10),
                  expands: true,
                  controller: _quillController,
                  readOnly: false,
                  customStyles: DefaultStyles(
                    paragraph: DefaultTextBlockStyle(
                      TextStyles.whiteButtonText.copyWith(color: textColor),
                      const VerticalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      const BoxDecoration(),
                    ),
                  ),
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('en', 'US'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AsyncSnapshotBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot)
      builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const AsyncSnapshotBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return errorWidget ?? Text('Error: ${snapshot.error}');
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}
