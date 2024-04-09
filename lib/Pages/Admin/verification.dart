import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Admin/verification_pane_builder.dart';
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
  late Future<void> _fetchData = Future<void>.value();

  @override
  void initState() {
    super.initState();
    _fetchData = _fetchDataFromDB();
  }

  Future<void> _fetchDataFromDB() async {
    await _fetchUsers();
    await _fetchVerificationRequests();
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

  void _nextRequest() {
    setState(() {
      verificationHandler.nextRequest();
    });
  }

  void _previousRequest() {
    setState(() {
      verificationHandler.previousRequest();
    });
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
      body: FutureBuilder<void>(
        future: _fetchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Padding(
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
                  _VerificationPane(
                    verificationHandler: verificationHandler,
                  ),
                  smallSizedBox,
                  _NavigationButtons(
                    verificationHandler: verificationHandler,
                    onNextPressed: _nextRequest,
                    onPreviousPressed: _previousRequest,
                  ),
                ],
              ),
            );
          }
        },
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
  final VoidCallback onNextPressed;
  final VoidCallback onPreviousPressed;

  const _NavigationButtons({
    required this.verificationHandler,
    required this.onNextPressed,
    required this.onPreviousPressed,
  });

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
            onPressed: onPreviousPressed,
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
            onPressed: onNextPressed,
          ),
        ],
      ),
    );
  }
}

class _VerificationPane extends StatefulWidget {
  final VerificationArrayHandler verificationHandler;

  const _VerificationPane({required this.verificationHandler});
  @override
  State<_VerificationPane> createState() => _VerificationPaneState();
}

class _VerificationPaneState extends State<_VerificationPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: background['500']!),
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: double.infinity,
      height: 400,
      child: SingleChildScrollView(
        child: VerificationPaneBuilder.buildVerificationPane(
            widget.verificationHandler.getRequestPackage(),
            widget.verificationHandler),
      ),
    );
  }
}

class VerificationArrayHandler {
  late List<dynamic> verificationRequests = [];
  int currentRequestIndex = 0;
  Map<String, dynamic> requestPackage = {};
  String currentEditType = '';
  String sectionName = '';
  String charLocName = '';

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
    if (verificationRequests.length - 1 == 0 || verificationRequests.isEmpty) {
      return;
    } else if (currentRequestIndex < verificationRequests.length - 1) {
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
    if (verificationRequests.length - 1 == 0 || verificationRequests.isEmpty) {
      return;
    } else if (currentRequestIndex > 0) {
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

  Future<void> awaitCharacterName() async {
    final dbHandler = DBHandler();
    charLocName = await dbHandler.getCharacterName(
        characterID: getRequestPackage()['characterID']);
  }

  String getCharacterName() {
    awaitCharacterName();
    return charLocName;
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
    final String userId = verificationRequest['submitter_user_id'];
    final Map<String, dynamic> user = users.firstWhere(
        (element) => element['id'] == userId,
        orElse: () => {'username': 'User Not Found'});
    return user['username'];
  }
}
