import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Admin/verification.dart';

List<String> editTypes = [
  //"editSectionDetail",
  "editLocationDetail",
  "editCharacterDetail",
  "editCharacter",
  //"editSection",
  "editLocation",
  "editWiki",
  //"deleteSectionDetail",
  "deleteLocationDetail",
  "deleteCharacterDetail",
  //"deleteSection",
  "deleteCharacter",
  "deleteLocation",
  "deleteWiki",
  "createCharacter",
  //"createSection",
  "createLocation",
  "createCharacterDetail",
  "createLocationDetail",
  //"createSectionDetail",
];

class VerificationPaneBuilder {
  static Widget buildVerificationPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final String editType = requestPackage['editType'].toString();
    switch (editType) {
      case 'editSectionDetail':
        return _buildEditSectionDetailPane(requestPackage, verificationHandler);
      case 'createSectionDetail':
        return _buildCreateSectionDetailPane(
            requestPackage, verificationHandler);
      case 'deleteSectionDetail':
        return _buildDeleteSectionDetailPane(
            requestPackage, verificationHandler);
      case 'editSection':
        return _buildEditSectionPane(requestPackage, verificationHandler);
      case 'createSection':
        return _buildCreateSectionPane(requestPackage, verificationHandler);
      case 'deleteSection':
        return _buildDeleteSectionPane(requestPackage, verificationHandler);
      /*
      case 'editCharacterDetail':
        return _buildEditCharacterDetailPane(requestPackage);
      case 'createCharacterDetail':
        return _buildCreateCharacterDetailPane(requestPackage);
      case 'editCharacter':
        return _buildEditCharacterPane(requestPackage);
      case 'deleteCharacter':
        return _buildDeleteCharacterPane(requestPackage);*/
      default:
        return FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: Global().columnMargins,
            child: Text(
              'No verification requests available',
              style: TextStyles.titleSmall,
            ),
          ),
        );
    }
  }

  static Widget _buildEditSectionDetailPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setInput(updatedEntry);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: SubmittedUserRow(verificationHandler: verificationHandler),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Edit Section Details for: ',
                      style: TextStyles.greyHintText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildEditor(),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: Text('Reason: $reason'),
          ),
          smallSizedBox,
        ],
      ),
    );
  }

  static Widget _buildCreateSectionDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setInput(updatedEntry);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: SubmittedUserRow(verificationHandler: verificationHandler),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Create Section Details for: ',
                      style: TextStyles.greyHintText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildEditor(),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: Text('Reason: $reason'),
          ),
          smallSizedBox,
        ],
      ),
    );
  }

  static Widget _buildDeleteSectionDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final String reason = requestPackage['reason'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: SubmittedUserRow(verificationHandler: verificationHandler),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Delete Section Details for: ',
                      style: TextStyles.greyHintText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Reason: ', style: TextStyles.greyHintText),
                  Text(reason, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
        ],
      ),
    );
  }

  static Widget _buildEditSectionPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final TextEditingController nameController = TextEditingController();
    final String reason = requestPackage['reason'];
    nameController.text = requestPackage['name'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: SubmittedUserRow(verificationHandler: verificationHandler),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Edit Section: ', style: TextStyles.greyHintText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: Row(
              children: [
                Text('Updated Name: ', style: TextStyles.greyHintText),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Reason: ', style: TextStyles.greyHintText),
                  Text(reason, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
        ],
      ),
    );
  }

  static Widget _buildCreateSectionPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final TextEditingController nameController = TextEditingController();
    final String reason = requestPackage['reason'];
    nameController.text = requestPackage['name'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: SubmittedUserRow(verificationHandler: verificationHandler),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Create a new Section',
                      style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: Row(
              children: [
                Text('Section Name: ', style: TextStyles.greyHintText),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Reason: ', style: TextStyles.greyHintText),
                  Text(reason, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
        ],
      ),
    );
  }

  static Widget _buildDeleteSectionPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final String reason = requestPackage['reason'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: SubmittedUserRow(verificationHandler: verificationHandler),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Delete Section: ', style: TextStyles.greyHintText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Text('Reason: ', style: TextStyles.greyHintText),
                  Text(reason, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
        ],
      ),
    );
  }
}

class SubmittedUserRow extends StatelessWidget {
  final VerificationArrayHandler verificationHandler;

  const SubmittedUserRow({super.key, required this.verificationHandler});

  @override
  Widget build(BuildContext context) {
    final UsersHandler usersHandler = UsersHandler();
    final String submittedUser =
        usersHandler.getSubmittedUser(verificationHandler.getCurrentRequest());

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text("Submitted by: ", style: TextStyles.greyHintText),
          Text(submittedUser, style: TextStyles.whiteButtonText),
        ],
      ),
    );
  }
}
