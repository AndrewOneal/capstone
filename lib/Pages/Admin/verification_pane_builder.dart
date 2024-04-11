import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/Admin/verification.dart';

class VerificationPaneBuilder {
  static Future<Widget> buildVerificationPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String editType = requestPackage['editType'].toString();
    switch (editType) {
      case 'editSectionDetail':
        return await _buildEditSectionDetailPane(
            requestPackage, verificationHandler);
      case 'createSectionDetail':
        return await _buildCreateSectionDetailPane(
            requestPackage, verificationHandler);
      case 'deleteSectionDetail':
        return await _buildDeleteSectionDetailPane(
            requestPackage, verificationHandler);
      case 'editSection':
        return await _buildEditSectionPane(requestPackage, verificationHandler);
      case 'createSection':
        return _buildCreateSectionPane(requestPackage, verificationHandler);
      case 'deleteSection':
        return await _buildDeleteSectionPane(
            requestPackage, verificationHandler);
      case 'editCharacterDetail':
        return await _buildEditCharacterDetailPane(
            requestPackage, verificationHandler);
      case 'createCharacterDetail':
        return await _buildCreateCharacterDetailPane(
            requestPackage, verificationHandler);
      case 'deleteCharacterDetail':
        return await _buildDeleteCharacterDetailPane(
            requestPackage, verificationHandler);
      case 'editCharacter':
        return await _buildEditCharacterPane(
            requestPackage, verificationHandler);
      case 'createCharacter':
        return _buildCreateCharacterPane(requestPackage, verificationHandler);
      case 'deleteCharacter':
        return await _buildDeleteCharacterPane(
            requestPackage, verificationHandler);
      case 'editLocationDetail':
        return await _buildEditLocationDetailPane(
            requestPackage, verificationHandler);
      case 'createLocationDetail':
        return await _buildCreateLocationDetailPane(
            requestPackage, verificationHandler);
      case 'deleteLocationDetail':
        return await _buildDeleteLocationDetailPane(
            requestPackage, verificationHandler);
      case 'editLocation':
        return await _buildEditLocationPane(
            requestPackage, verificationHandler);
      case 'createLocation':
        return _buildCreateLocationPane(requestPackage, verificationHandler);
      case 'deleteLocation':
        return await _buildDeleteLocationPane(
            requestPackage, verificationHandler);
      case 'editWiki':
        return await _buildEditWikiPane(requestPackage, verificationHandler);
      case 'deleteWiki':
        return await _buildDeleteWikiPane(requestPackage, verificationHandler);
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

  static Future<Widget> _buildEditSectionDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text(sectionName, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildCreateSectionDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text(sectionName, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildDeleteSectionDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text(sectionName, style: TextStyles.whiteButtonText),
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

  static Future<Widget> _buildEditSectionPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String updatedName = requestPackage['name'];
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text(sectionName, style: TextStyles.whiteButtonText),
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
                  Text('Updated Name: ', style: TextStyles.greyHintText),
                  Text(updatedName, style: TextStyles.whiteButtonText),
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

  static Widget _buildCreateSectionPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final String reason = requestPackage['reason'];
    final String sectionName = requestPackage['name'];

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text('Create a new Section',
                          style: TextStyles.greyHintText),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text('Section Name: ', style: TextStyles.greyHintText),
                      Text(sectionName, style: TextStyles.whiteButtonText),
                    ],
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

  static Future<Widget> _buildDeleteSectionPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text(sectionName, style: TextStyles.whiteButtonText),
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

  static Future<Widget> _buildEditCharacterDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String characterName = await verificationHandler.getCharacterName();
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text('Edit Character Details for: ',
                      style: TextStyles.greyHintText),
                  Text(characterName, style: TextStyles.whiteButtonText),
                  Text(' - ', style: TextStyles.greyHintText),
                  Text(sectionName, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildCreateCharacterDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String characterName = await verificationHandler.getCharacterName();
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text('Create Character Details for: ',
                      style: TextStyles.greyHintText),
                  Text(characterName, style: TextStyles.whiteButtonText),
                  Text(' - ', style: TextStyles.greyHintText),
                  Text(sectionName, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildDeleteCharacterDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String characterName = await verificationHandler.getCharacterName();
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text('Delete Character Details for: ',
                      style: TextStyles.greyHintText),
                  Text(characterName, style: TextStyles.whiteButtonText),
                  Text(' - ', style: TextStyles.greyHintText),
                  Text(sectionName, style: TextStyles.whiteButtonText),
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

  static Future<Widget> _buildEditCharacterPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String updatedName = requestPackage['name'];
    final String characterName = await verificationHandler.getCharacterName();

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
                  Text('Edit Character: ', style: TextStyles.greyHintText),
                  Text(characterName, style: TextStyles.whiteButtonText),
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
                  Text('Updated Name: ', style: TextStyles.greyHintText),
                  Text(updatedName, style: TextStyles.whiteButtonText),
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

  static Widget _buildCreateCharacterPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final String reason = requestPackage['reason'];
    final String characterName = requestPackage['name'];

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text('Create a new Character',
                          style: TextStyles.greyHintText),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text('Character Name: ', style: TextStyles.greyHintText),
                      Text(characterName, style: TextStyles.whiteButtonText),
                    ],
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

  static Future<Widget> _buildDeleteCharacterPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String characterName = await verificationHandler.getCharacterName();

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
                  Text('Delete Character: ', style: TextStyles.greyHintText),
                  Text(characterName, style: TextStyles.whiteButtonText),
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

  static Future<Widget> _buildEditLocationDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String locationName = await verificationHandler.getLocationName();
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text('Edit Location Details for: ',
                      style: TextStyles.greyHintText),
                  Text(locationName, style: TextStyles.whiteButtonText),
                  Text(' - ', style: TextStyles.greyHintText),
                  Text(sectionName, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildCreateLocationDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String locationName = await verificationHandler.getLocationName();
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text('Create Location Details for: ',
                      style: TextStyles.greyHintText),
                  Text(locationName, style: TextStyles.whiteButtonText),
                  Text(' - ', style: TextStyles.greyHintText),
                  Text(sectionName, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildDeleteLocationDetailPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String locationName = await verificationHandler.getLocationName();
    final String sectionName = await verificationHandler.getSectionName();

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
                  Text('Delete Location Details for: ',
                      style: TextStyles.greyHintText),
                  Text(locationName, style: TextStyles.whiteButtonText),
                  Text(' - ', style: TextStyles.greyHintText),
                  Text(sectionName, style: TextStyles.whiteButtonText),
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

  static Future<Widget> _buildEditLocationPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String updatedName = requestPackage['name'];
    final String locationName = await verificationHandler.getLocationName();

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
                  Text('Edit Location: ', style: TextStyles.greyHintText),
                  Text(locationName, style: TextStyles.whiteButtonText),
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
                  Text('Updated Name: ', style: TextStyles.greyHintText),
                  Text(updatedName, style: TextStyles.whiteButtonText),
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

  static Widget _buildCreateLocationPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) {
    final String reason = requestPackage['reason'];
    final String locationName = requestPackage['name'];

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text('Create a new Location',
                          style: TextStyles.greyHintText),
                    ],
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text('Location Name: ', style: TextStyles.greyHintText),
                      Text(locationName, style: TextStyles.whiteButtonText),
                    ],
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

  static Future<Widget> _buildDeleteLocationPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String locationName = await verificationHandler.getLocationName();

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
                  Text('Delete Location: ', style: TextStyles.greyHintText),
                  Text(locationName, style: TextStyles.whiteButtonText),
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

  static Future<Widget> _buildEditWikiPane(Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];
    final String title = requestPackage['title'];
    final String wikiTitle = verificationHandler.getWikiTitle();

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;
    final EdgeInsets columnMargins = global.columnMargins;

    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setBackgroundColor(lightPurple['200']!);
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
                  Text('Edit Wiki: ', style: TextStyles.greyHintText),
                  Text(wikiTitle, style: TextStyles.whiteButtonText),
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
                  Text('Updated Wiki: ', style: TextStyles.greyHintText),
                  Text(title, style: TextStyles.whiteButtonText),
                ],
              ),
            ),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Padding(
            padding: columnMargins,
            child: quillEditor.buildRead(),
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

  static Future<Widget> _buildDeleteWikiPane(
      Map<String, dynamic> requestPackage,
      VerificationArrayHandler verificationHandler) async {
    final String reason = requestPackage['reason'];
    final String wikiTitle = verificationHandler.getWikiTitle();

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
                  Text('Delete Wiki: ', style: TextStyles.greyHintText),
                  Text(wikiTitle, style: TextStyles.whiteButtonText),
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
