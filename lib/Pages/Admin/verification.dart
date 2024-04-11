import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Admin/verification_pane_builder.dart';

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
  final DBHandler dbHandler = DBHandler();

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

  void _updateRequest() {
    dbHandler.deleteVerificationRequests(
        verification_record_id: verificationHandler.getCurrentRequest()['id']);
    verificationHandler.removeRequest();
    setState(() {
      if (verificationHandler.getVerificationRequests().length ==
          verificationHandler.getCurrentIndex()) {
        verificationHandler.nextRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String wikiTitle = widget.wikiMap['wiki_name'];
    verificationHandler.setWikiTitle(wikiTitle);
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
                  _AcceptRejectButtons(
                    verificationHandler: verificationHandler,
                    updateRequest: _updateRequest,
                  ),
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
  final VerificationArrayHandler verificationHandler;
  final VoidCallback updateRequest;
  const _AcceptRejectButtons({
    required this.verificationHandler,
    required this.updateRequest,
  });

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    const double iconSize = 30;
    DBHandler dbHandler = DBHandler();
    final String editType = verificationHandler.getCurrentEditType();
    const int sectionNo = 0;

    void acceptEditSectionDetail() {
      dbHandler.updateSectionDetail(
          sectionDetailID: verificationHandler.getCurrentRequest()['id'],
          new_details_description:
              verificationHandler.getRequestPackage()['updatedEntry']);
    }

    void acceptEditLocationDetail() {
      dbHandler.updateLocationDetail(
          locationDetailID: verificationHandler.getCurrentRequest()['id'],
          new_details_description:
              verificationHandler.getRequestPackage()['updatedEntry']);
    }

    void acceptEditCharacterDetail() {
      dbHandler.updateCharacterDetail(
          characterDetailsID: verificationHandler.getCurrentRequest()['id'],
          new_details_description:
              verificationHandler.getRequestPackage()['updatedEntry']);
    }

    void acceptEditSection() {
      dbHandler.updateSection(
          sectionID: verificationHandler.getRequestPackage()['sectionID'],
          new_section_name: verificationHandler.getRequestPackage()['name']);
    }

    void acceptEditLocation() {
      dbHandler.updateLocation(
          locationID: verificationHandler.getRequestPackage()['locationID'],
          new_location_name: verificationHandler.getRequestPackage()['name']);
    }

    void acceptEditCharacter() {
      dbHandler.updateCharacter(
        characterID: verificationHandler.getRequestPackage()['characterID'],
        new_name: verificationHandler.getRequestPackage()['name'],
        new_nickname: verificationHandler.getRequestPackage()['name'],
      );
    }

    void acceptEditWiki() {
      dbHandler.updateWiki(
        wikiID: verificationHandler.getCurrentRequest()['wikiID'],
        new_name: verificationHandler.getRequestPackage()['title'],
        new_description:
            verificationHandler.getRequestPackage()['updatedEntry'],
      );
    }

    void acceptDeleteSectionDetail() {
      dbHandler.deleteSectionDetail(
          sectionDetailID: verificationHandler.getCurrentRequest()['id']);
    }

    void acceptDeleteLocationDetail() {
      dbHandler.deleteLocationDetail(
          locationDetailID: verificationHandler.getCurrentRequest()['id']);
    }

    void acceptDeleteCharacterDetail() {
      dbHandler.deleteCharacterDetail(
          characterDetailID: verificationHandler.getCurrentRequest()['id']);
    }

    void acceptDeleteSection() {
      dbHandler.deleteSection(
          sectionID: verificationHandler.getRequestPackage()['sectionID']);
    }

    void acceptDeleteLocation() {
      dbHandler.deleteLocation(
          locationID: verificationHandler.getRequestPackage()['locationID']);
    }

    void acceptDeleteCharacter() {
      dbHandler.deleteCharacter(
          characterID: verificationHandler.getRequestPackage()['characterID']);
    }

    void acceptDeleteWiki() {
      dbHandler.deleteWiki(
          wikiID: verificationHandler.getCurrentRequest()['wikiID']);
    }

    void acceptCreateSection() {
      dbHandler.createSection(
          associated_wiki_id: verificationHandler.getCurrentRequest()['wikiID'],
          section_name: verificationHandler.getRequestPackage()['name'],
          section_no: sectionNo);
    }

    void acceptCreateLocation() {
      dbHandler.createLocation(
          associated_wiki_id: verificationHandler.getCurrentRequest()['wikiID'],
          location_name: verificationHandler.getRequestPackage()['name']);
    }

    void acceptCreateCharacter() {
      dbHandler.createCharacter(
          associated_wiki_id: verificationHandler.getCurrentRequest()['wikiID'],
          character_name: verificationHandler.getRequestPackage()['name']);
    }

    void acceptCreateSectionDetail() {
      dbHandler.createSectionDetail(
          associated_section_id:
              verificationHandler.getRequestPackage()['sectionID'],
          details_description:
              verificationHandler.getRequestPackage()['updatedEntry']);
    }

    void acceptCreateLocationDetail() {
      dbHandler.createLocationDetail(
          associated_location_id:
              verificationHandler.getRequestPackage()['locationID'],
          associated_section_id:
              verificationHandler.getRequestPackage()['sectionID'],
          details_description:
              verificationHandler.getRequestPackage()['updatedEntry']);
    }

    void acceptCreateCharacterDetail() {
      dbHandler.createCharacterDetail(
          associated_character_id:
              verificationHandler.getRequestPackage()['characterID'],
          associated_section_id:
              verificationHandler.getRequestPackage()['sectionID'],
          details_description:
              verificationHandler.getRequestPackage()['updatedEntry']);
    }

    void acceptAction() {
      switch (editType) {
        case 'editSectionDetail':
          acceptEditSectionDetail();
          break;
        case 'editLocationDetail':
          acceptEditLocationDetail();
          break;
        case 'editCharacterDetail':
          acceptEditCharacterDetail();
          break;
        case 'editSection':
          acceptEditSection();
          break;
        case 'editLocation':
          acceptEditLocation();
          break;
        case 'editCharacter':
          acceptEditCharacter();
          break;
        case 'editWiki':
          acceptEditWiki();
          break;
        case 'deleteSectionDetail':
          acceptDeleteSectionDetail();
          break;
        case 'deleteLocationDetail':
          acceptDeleteLocationDetail();
          break;
        case 'deleteCharacterDetail':
          acceptDeleteCharacterDetail();
          break;
        case 'deleteSection':
          acceptDeleteSection();
          break;
        case 'deleteLocation':
          acceptDeleteLocation();
          break;
        case 'deleteCharacter':
          acceptDeleteCharacter();
          break;
        case 'deleteWiki':
          acceptDeleteWiki();
          break;
        case 'createSection':
          acceptCreateSection();
          break;
        case 'createLocation':
          acceptCreateLocation();
          break;
        case 'createCharacter':
          acceptCreateCharacter();
          break;
        case 'createSectionDetail':
          acceptCreateSectionDetail();
          break;
        case 'createLocationDetail':
          acceptCreateLocationDetail();
          break;
        case 'createCharacterDetail':
          acceptCreateCharacterDetail();
          break;
        default:
          break;
      }
    }

    return Padding(
      padding: sideMargins,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            color: Colors.green,
            iconSize: iconSize,
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                        content: Text('Accepting Request'),
                        duration: Duration(seconds: 1)),
                  )
                  .closed
                  .then((reason) {
                updateRequest();
              });
              acceptAction();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            iconSize: iconSize,
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                        content: Text('Deleting Request'),
                        duration: Duration(seconds: 1)),
                  )
                  .closed
                  .then((reason) {
                updateRequest();
              });
            },
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
                  '${verificationHandler.getCurrentIndex() + 1} / ${verificationHandler.getVerificationRequests().length}',
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
        child: FutureBuilder<Widget>(
          future: VerificationPaneBuilder.buildVerificationPane(
            widget.verificationHandler.getRequestPackage(),
            widget.verificationHandler,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data ?? Container();
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
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
  String wikiTitle = '';
  String entryID = '';

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

  int getCurrentIndex() {
    return currentRequestIndex;
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

  Future<String> getCharacterName() async {
    await awaitCharacterName();
    return charLocName;
  }

  Future<void> awaitSectionName() async {
    final dbHandler = DBHandler();
    sectionName = await dbHandler.getSectionNameFromID(
        sectionID: getRequestPackage()['sectionID']);
  }

  Future<String> getSectionName() async {
    await awaitSectionName();
    return sectionName;
  }

  Future<void> awaitLocationName() async {
    final dbHandler = DBHandler();
    charLocName = await dbHandler.getLocationNameFromID(
        locationID: getRequestPackage()['locationID']);
  }

  Future<String> getLocationName() async {
    await awaitLocationName();
    return charLocName;
  }

  void setWikiTitle(String newWikiTitle) {
    wikiTitle = newWikiTitle;
  }

  String getWikiTitle() {
    return wikiTitle;
  }

  String getEntryID() {
    return entryID;
  }

  void removeRequest() {
    verificationRequests.removeAt(currentRequestIndex);
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
