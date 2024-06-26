import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditCharacters extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> charactersMap;

  const EditCharacters({
    super.key,
    required this.wikiMap,
    required this.charactersMap,
  });

  @override
  EditCharactersState createState() => EditCharactersState();
}

class EditCharactersState extends State<EditCharacters> {
  late CharacterHandler characterHandler;

  @override
  void initState() {
    super.initState();
    characterHandler = CharacterHandler();
    widget.charactersMap.isNotEmpty
        ? characterHandler.setCharacterMap(widget.charactersMap)
        : {};
  }

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ListTitle(title: 'Edit Characters'),
                SingleChildScrollView(
                  child: _EditCharForm(
                    wikiMap: widget.wikiMap,
                    characterHandler: characterHandler,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditCharForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController;
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final CharacterHandler characterHandler;

  _EditCharForm({
    required this.wikiMap,
    required this.characterHandler,
  })  : _reasonForEditController = TextEditingController(),
        nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final DBHandler dbHandler = DBHandler();
    final double buttonWidth = MediaQuery.of(context).size.width > 514
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width * 0.8;

    final Widget submitButton = DarkButton(
      buttonText: "Submit For Approval",
      buttonWidth: buttonWidth,
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              const SnackBar(
                  content: Text('Submitting Request'),
                  duration: Duration(seconds: 1)),
            )
            .closed
            .then((reason) {
          Navigator.pop(context);
        });
        String characterID = characterHandler.getCharacterID();
        String editType =
            characterID.isEmpty ? "createCharacter" : "editCharacter";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "editType": editType,
            "characterID": characterID,
            "name": nameController.text,
            "reason": _reasonForEditController.text,
          },
        );
      },
    );

    final Widget deleteButton = DarkButton(
      buttonText: "Delete Character",
      buttonWidth: buttonWidth,
      onPressed: () {
        String characterID = characterHandler.getCharacterID();
        characterID.isEmpty
            ? {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text("Can't delete an entry that does not exist"),
                      duration: Duration(seconds: 1)),
                )
              }
            : {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      const SnackBar(
                          content: Text("Submitting Request"),
                          duration: Duration(seconds: 1)),
                    )
                    .closed
                    .then((reason) {
                  Navigator.pop(context);
                }),
                dbHandler.createVerificationRequest(
                  submitterUserID: pb.authStore.model.id,
                  wikiID: wikiID,
                  requestPackage: {
                    "edit_type": "deleteCharacter",
                    "characterID": characterID,
                    "reason": _reasonForEditController.text,
                  },
                ),
              };
      },
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          _CharacterDropdown(
            wikiID: wikiID,
            characterHandler: characterHandler,
            nameController: nameController,
          ),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: _reasonForEditController,
            decoration: const InputDecoration(
              labelText: 'Reason for Edit',
            ),
          ),
          largeSizedBox,
          MediaQuery.of(context).size.width > 514
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    submitButton,
                    deleteButton,
                  ],
                )
              : Column(
                  children: [
                    submitButton,
                    largeSizedBox,
                    deleteButton,
                  ],
                ),
          extraLargeSizedBox,
        ],
      ),
    );
  }
}

class _CharacterDropdown extends StatefulWidget {
  final String wikiID;
  final CharacterHandler characterHandler;
  final TextEditingController nameController;

  const _CharacterDropdown(
      {required this.wikiID,
      required this.characterHandler,
      required this.nameController});

  @override
  _CharacterDropdownState createState() => _CharacterDropdownState();
}

class _CharacterDropdownState extends State<_CharacterDropdown> {
  late List<dynamic> characters;
  late String id = '';
  late String name = '';

  @override
  void initState() {
    super.initState();
    characters = widget.characterHandler.getCharacterMap();
    if (characters.isEmpty) {
      id = 'CREATEACHARACTER';
    } else {
      id = characters[0]['id'];
      name = widget.characterHandler.getNameFromID(id);
      widget.nameController.text = name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: id,
      isExpanded: true,
      onChanged: (index) {
        setState(() {
          id = index!;
          name = widget.characterHandler.getNameFromID(id);
          widget.nameController.text = name;
        });
      },
      items: characters.isEmpty
          ? [
              DropdownMenuItem<String>(
                value: 'CREATEACHARACTER',
                child: Text(
                  'Create a Character',
                  style: TextStyles.listText,
                ),
              ),
            ]
          : [
              ...characters.map<DropdownMenuItem<String>>((character) {
                final characterID = character['id'];
                final characterName = character['name'];
                return DropdownMenuItem<String>(
                  value: characterID,
                  child: Text(
                    characterName,
                    style: TextStyles.listText,
                  ),
                );
              }),
              DropdownMenuItem<String>(
                value: 'CREATEACHARACTER',
                child: Text(
                  'Create a Character',
                  style: TextStyles.listText,
                ),
              ),
            ],
    );
  }
}

class CharacterHandler {
  List<dynamic> charactersMap = [];
  Map<String, dynamic> entry = {};

  void setCharacterMap(List<dynamic> characterMap) {
    charactersMap = characterMap;
  }

  void setEntryFromID(String characterID) {
    for (Map<String, dynamic> character in charactersMap) {
      final entryID = character['id'].toString();
      if (entryID.contains(characterID)) {
        entry = character;
        return;
      }
    }
    entry = {};
    return;
  }

  String getCharacterID() {
    if (entry.isNotEmpty) {
      return entry['id'];
    }
    return '';
  }

  String getNameFromID(String id) {
    setEntryFromID(id);
    if (entry.isNotEmpty) {
      return entry['name'];
    }
    return '';
  }

  List<dynamic> getCharacterMap() {
    return charactersMap;
  }
}
