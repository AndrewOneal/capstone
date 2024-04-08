import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'dart:convert';

class VerificationPage extends StatefulWidget {
  final Map<String, dynamic> wikiMap;

  const VerificationPage({super.key, required this.wikiMap});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final VerificationArrayHandler verificationHandler =
      VerificationArrayHandler();
  final UsersHandler usersHandler = UsersHandler();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _fetchVerificationRequests();
  }

  Future<void> _fetchUsers() async {
    final dbHandler = DBHandler();
    final dbUsers = await dbHandler.getUsers();
    usersHandler.setUsers(dbUsers);
  }

  Future<void> _fetchVerificationRequests() async {
    final dbHandler = DBHandler();
    final dbVerificationRequests =
        await dbHandler.getVerificationRequests(wiki_id: widget.wikiMap['id']);
    verificationHandler.setVerificationRequests(dbVerificationRequests);
  }

  @override
  Widget build(BuildContext context) {
    final String wikiTitle = widget.wikiMap['wiki_name'];
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox smallSizedBox = global.smallSizedBox;
    final SizedBox mediumSizedBox = global.mediumSizedBox;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: sideMargins,
        child: Column(
          children: [
            TwoLineTitle(
                firstLineText: wikiTitle,
                secondLineText: "Verification Requests",
                height: 150,
                purple: 1),
            mediumSizedBox,
            const _AcceptRejectButtons(),
            smallSizedBox,
            _VerificationPane(),
            smallSizedBox,
            _NavigationButtons(
              verificationHandler: verificationHandler,
            ),
          ],
        ),
      ),
    );
  }
}

class _AcceptRejectButtons extends StatelessWidget {
  const _AcceptRejectButtons();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    const double iconSize = 30;

    return Padding(
      padding: sideMargins,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            color: Colors.green,
            iconSize: iconSize,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            iconSize: iconSize,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  final VerificationArrayHandler verificationHandler;
  const _NavigationButtons({required this.verificationHandler});

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    const double iconSize = 30;

    return Padding(
      padding: sideMargins,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: iconSize,
            onPressed: () {
              verificationHandler.previousRequest();
            },
          ),
          verificationHandler.getVerificationRequests().isEmpty
              ? const Text(
                  '0 / 0',
                  style: TextStyle(fontSize: 20),
                )
              : Text(
                  '${verificationHandler.getCurrentIndex()} / ${verificationHandler.getVerificationRequests().length}',
                  style: const TextStyle(fontSize: 20),
                ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            iconSize: iconSize,
            onPressed: () {
              verificationHandler.nextRequest();
            },
          ),
        ],
      ),
    );
  }
}

class _VerificationPane extends StatefulWidget {
  @override
  State<_VerificationPane> createState() => _VerificationPaneState();
}

class _VerificationPaneState extends State<_VerificationPane> {
  @override
  Widget build(BuildContext context) {
    const EdgeInsets columnMargins = EdgeInsets.symmetric(horizontal: 5);
    final TextEditingController submittedUserController =
        TextEditingController();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: background['500']!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: double.infinity,
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: columnMargins,
              child: Row(
                children: [
                  /*Text("Submitted by: ", style: TextStyle(color: text['300'])),
                  Expanded(
                    child: TextField(
                      controller: submittedUserController,
                      readOnly: true,
                      style: TextStyle(color: text['default']),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        enabled: false,
                        hintText: "Username",
                      ),
                    ),
                  ),*/
                  VerificationPaneBuilder.buildVerificationPane(
                      VerificationArrayHandler().getRequestPackage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationArrayHandler {
  static final VerificationArrayHandler _instance =
      VerificationArrayHandler._internal();

  factory VerificationArrayHandler() {
    return _instance;
  }

  VerificationArrayHandler._internal();

  late List<dynamic> verificationRequests = [];
  int currentRequestIndex = 0;
  Map<String, dynamic> requestPackage = {};
  String currentEditType = '';

  List<dynamic> getVerificationRequests() {
    return verificationRequests;
  }

  Map<String, dynamic> getCurrentRequest() {
    return verificationRequests[currentRequestIndex];
  }

  void setVerificationRequests(List<dynamic> newVerificationRequests) {
    if (newVerificationRequests.isNotEmpty) {
      verificationRequests = newVerificationRequests;
      setRequestPackage(verificationRequests[currentRequestIndex]);
      setCurrentEditType(getRequestPackage()['editType']);
    } else {
      verificationRequests = [];
    }
  }

  void nextRequest() {
    if (currentRequestIndex < verificationRequests.length - 1) {
      currentRequestIndex++;
      setRequestPackage(verificationRequests[currentRequestIndex]);
      setCurrentEditType(getRequestPackage()['editType']);
    } else {
      currentRequestIndex = 0;
      setRequestPackage(verificationRequests[currentRequestIndex]);
      setCurrentEditType(getRequestPackage()['editType']);
    }
  }

  void previousRequest() {
    if (currentRequestIndex > 0) {
      currentRequestIndex--;
      setRequestPackage(verificationRequests[currentRequestIndex]);
      setCurrentEditType(getRequestPackage()['editType']);
    } else {
      currentRequestIndex = verificationRequests.length - 1;
      setRequestPackage(verificationRequests[currentRequestIndex]);
      setCurrentEditType(getRequestPackage()['editType']);
    }
  }

  String getCurrentIndex() {
    return (currentRequestIndex + 1).toString();
  }

  String getCurrentEditType() {
    return currentEditType;
  }

  void setCurrentEditType(String newEditType) {
    currentEditType = newEditType;
  }

  void setRequestPackage(Map<String, dynamic> currentVerificationRequest) {
    requestPackage = currentVerificationRequest['request_package'];
  }

  Map<String, dynamic> getRequestPackage() {
    return requestPackage;
  }
}

class UsersHandler {
  static final UsersHandler _instance = UsersHandler._internal();

  factory UsersHandler() {
    return _instance;
  }

  UsersHandler._internal();

  late List<dynamic> users = [];

  List<dynamic> getUsers() {
    return users;
  }

  void setUsers(List<dynamic> newUsers) {
    users = newUsers;
  }

  String getSubmittedUser(Map<String, dynamic> verificationRequest) {
    final int userId = verificationRequest['user_id'];
    final Map<String, dynamic> user = users.firstWhere(
        (element) => element['user_id'] == userId,
        orElse: () => {'username': 'User Not Found'});
    return user['username'];
  }
}

List<String> editTypes = [
  "editSectionDetail",
  "editLocationDetail",
  "editCharacterDetail",
  "editCharacter",
  "editSection",
  "editLocation",
  "editWiki",
  "deleteSectionDetail",
  "deleteLocationDetail",
  "deleteCharacterDetail",
  "deleteSection",
  "deleteCharacter",
  "deleteLocation",
  "deleteWiki",
  "createCharacter",
  "createSection",
  "createLocation",
  "createCharacterDetail",
  "createLocationDetail",
  "createCharacterDetail",
  "createSectionDetail"
];

class VerificationPaneBuilder {
  static Widget buildVerificationPane(Map<String, dynamic> requestPackage) {
    final String editType = requestPackage['editType'].toString();
    switch (editType) {
      case 'editSectionDetail':
        return _buildEditSectionDetailPane(requestPackage);
      /*case 'editSection':
        return _buildEditSectionPane(requestPackage);
      case 'editCharacterDetail':
        return _buildEditCharacterDetailPane(requestPackage);
      case 'createCharacterDetail':
        return _buildCreateCharacterDetailPane(requestPackage);
      case 'editCharacter':
        return _buildEditCharacterPane(requestPackage);
      case 'deleteCharacter':
        return _buildDeleteCharacterPane(requestPackage);*/
      default:
        return Text(
          'No verification requests available',
          style: TextStyles.titleSmall,
        );
    }
  }

  static Widget _buildEditSectionDetailPane(
      Map<String, dynamic> requestPackage) {
    final List<Map<String, dynamic>> updatedEntry =
        (requestPackage['updatedEntry'] as List).cast<Map<String, dynamic>>();
    final String reason = requestPackage['reason'];

    Global global = Global();
    final SizedBox smallSizedBox = global.smallSizedBox;

    QuillEditorManager quillEditor = QuillEditorManager();
    quillEditor.setInput(updatedEntry);

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('Edit Section Detail'),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          SizedBox(
            width: 500,
            child: quillEditor.buildEditor(),
          ),
          smallSizedBox,
          const Divider(),
          smallSizedBox,
          Text('Reason: $reason'),
        ],
      ),
    );
  }
/*
  static Widget _buildEditSectionPane(Map<String, dynamic> requestPackage) {
    final String sectionName = requestPackage['name'];
    final String reason = requestPackage['reason'];

    // Build UI for edit section, including displaying sectionName and reason
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display sectionName
          // Display reason for the edit
        ],
      ),
    );
  }

  // Implement similar methods for other edit types...

  // Example method for creating edit character detail pane
  static Widget _buildEditCharacterDetailPane(
      Map<String, dynamic> requestPackage) {
    final List<Map<String, dynamic>> updatedEntry =
        requestPackage['updatedEntry'];
    final String reason = requestPackage['reason'];

    // Build UI for edit character detail, including displaying updatedEntry and reason
    return SingleChildScrollView(
      child: Column(
        children: [
          // Display updatedEntry using Flutter Quill editor or simple text widget
          // Display reason for the edit
        ],
      ),
    );
  }

  // Add more builder methods for other edit types...*/
}
