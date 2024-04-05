import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

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
    final dbVerificationRequests = await dbHandler.getVerificationRequests(
        wiki_id: widget.wikiMap['wiki_id']);
    verificationHandler.setVerificationRequests(dbVerificationRequests);
  }

  @override
  Widget build(BuildContext context) {
    final String wikiTitle = widget.wikiMap['wiki_name'];
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
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
            _VerificationPane(),
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

class _VerificationPane extends StatefulWidget {
  @override
  State<_VerificationPane> createState() => _VerificationPaneState();
}

class _VerificationPaneState extends State<_VerificationPane> {
  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    const EdgeInsets columnMargins = EdgeInsets.symmetric(horizontal: 5);
    final TextEditingController submittedUserController =
        TextEditingController();
    final TextEditingController editTypeController = TextEditingController();
    editTypeController.text = 'Test';
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: background['500']!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: double.infinity,
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: columnMargins,
              child: Row(
                children: [
                  Text("Submitted by: ", style: TextStyle(color: text['300'])),
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
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: columnMargins,
              child: Row(
                children: [
                  Text("Edit Type: ", style: TextStyle(color: text['300'])),
                  Expanded(
                    child: TextField(
                      controller: editTypeController,
                      readOnly: true,
                      style: TextStyle(color: text['default']),
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        enabled: false,
                        hintText: "Edit Type",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
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
  EditTypeHandler editTypeHandler = EditTypeHandler();

  List<dynamic> getVerificationRequests() {
    return verificationRequests;
  }

  Map<String, dynamic> getCurrentRequest() {
    return verificationRequests[currentRequestIndex];
  }

  void setVerificationRequests(List<dynamic> newVerificationRequests) {
    verificationRequests = newVerificationRequests;
    editTypeHandler
        .setEditType(verificationRequests[currentRequestIndex]['edit_type']);
  }

  void nextRequest() {
    if (currentRequestIndex < verificationRequests.length - 1) {
      currentRequestIndex++;
      editTypeHandler
          .setEditType(verificationRequests[currentRequestIndex]['edit_type']);
    } else {
      currentRequestIndex = 0;
      editTypeHandler
          .setEditType(verificationRequests[currentRequestIndex]['edit_type']);
    }
  }

  void previousRequest() {
    if (currentRequestIndex > 0) {
      currentRequestIndex--;
      editTypeHandler
          .setEditType(verificationRequests[currentRequestIndex]['edit_type']);
    } else {
      currentRequestIndex = verificationRequests.length - 1;
      editTypeHandler
          .setEditType(verificationRequests[currentRequestIndex]['edit_type']);
    }
  }

  String getCurrentIndex() {
    return (currentRequestIndex + 1).toString();
  }
}

class EditTypeHandler {
  static final EditTypeHandler _instance = EditTypeHandler._internal();

  factory EditTypeHandler() {
    return _instance;
  }

  EditTypeHandler._internal();

  late String editType = '';

  String getEditType() {
    return editType;
  }

  void setEditType(String newEditType) {
    editType = newEditType;
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

class RequestPackageHandler {
  final VerificationArrayHandler verificationHandler =
      VerificationArrayHandler();
  final UsersHandler usersHandler = UsersHandler();
  final EditTypeHandler editTypeHandler = EditTypeHandler();
  Map<String, dynamic> requestPackage = {};

  void setRequestPackage() {
    requestPackage = verificationHandler.getCurrentRequest()['request_package'];
    editTypeHandler.setEditType(requestPackage['edit_type']);
  }

  Map<String, dynamic> getRequestPackage() {
    return requestPackage;
  }

  String getEntryID() {
    return requestPackage['entryID'];
  }

  String getReason() {
    return requestPackage['reason'];
  }

  String getName() {
    return requestPackage['name'];
  }

  List<Map<String, dynamic>> getUpdatedEntry() {
    return requestPackage['updatedEntry'];
  }

  String getCharacterID() {
    return requestPackage['characterID'];
  }

  String getSectionID() {
    return requestPackage['sectionID'];
  }

  String getLocationID() {
    return requestPackage['locationID'];
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
  final VerificationArrayHandler verificationHandler =
      VerificationArrayHandler();
  final UsersHandler usersHandler = UsersHandler();
}
