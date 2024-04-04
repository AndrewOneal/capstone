import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditLocations extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> locationsMap;

  const EditLocations({
    super.key,
    required this.wikiMap,
    required this.locationsMap,
  });

  @override
  EditLocationsState createState() => EditLocationsState();
}

class EditLocationsState extends State<EditLocations> {
  @override
  Widget build(BuildContext context) {
    final LocationHandler locationHandler =
        LocationHandler(locationsMap: widget.locationsMap);
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
                const ListTitle(title: 'Edit Locations'),
                SingleChildScrollView(
                  child: _EditCharForm(
                    wikiMap: widget.wikiMap,
                    locationHandler: locationHandler,
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
  final LocationHandler locationHandler;

  _EditCharForm({
    required this.wikiMap,
    required this.locationHandler,
  })  : _reasonForEditController = TextEditingController(),
        nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox mediumSizedBox = global.mediumSizedBox;
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
        String id = locationHandler.getEntryID();
        String editType = id == '' ? "createLocation" : "editLocation";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "edit_type": editType,
            "id": id,
            "updatedEntry": '',
            "reason": _reasonForEditController.text,
          },
        );
      },
    );

    final Widget deleteButton = DarkButton(
      buttonText: "Delete Location",
      buttonWidth: buttonWidth,
      onPressed: () {
        String id = locationHandler.getEntryID();
        id.isEmpty
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
                    "edit_type": "deleteLocation",
                    "id": id,
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
          _LocationDropdown(
            wikiID: wikiID,
            locationHandler: locationHandler,
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
          mediumSizedBox,
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

class _LocationDropdown extends StatefulWidget {
  final String wikiID;
  final LocationHandler locationHandler;
  final TextEditingController nameController;

  const _LocationDropdown(
      {required this.wikiID,
      required this.locationHandler,
      required this.nameController});

  @override
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<_LocationDropdown> {
  late List<dynamic> locations;
  late String id = '';
  late String name = '';

  @override
  void initState() {
    super.initState();
    id = widget.locationHandler.getEntryID();
    name = widget.locationHandler.getNameFromID(id);
    locations = widget.locationHandler.getLocationMap();
    widget.nameController.text = name;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: id,
      isExpanded: true,
      onChanged: (index) {
        setState(() {
          id = index!;
          name = widget.locationHandler.getNameFromID(id);
          widget.nameController.text = name;
        });
      },
      items: [
        ...locations.map<DropdownMenuItem<String>>((location) {
          final locationID = location['id'];
          final locationName = location['name'];
          return DropdownMenuItem<String>(
            value: locationID,
            child: Text(locationName, style: TextStyles.listText),
          );
        }),
        DropdownMenuItem<String>(
          value: 'CREATEALOCATION',
          child: Text('Create a Location', style: TextStyles.listText),
        ),
      ],
    );
  }
}

class LocationHandler {
  final List<dynamic> locationsMap;
  Map<String, dynamic> entry = {};

  LocationHandler({required this.locationsMap}) : entry = locationsMap[0] ?? {};

  void setEntryFromID(String locationID) {
    for (Map<String, dynamic> location in locationsMap) {
      final entryID = location['id'].toString();
      if (entryID.contains(locationID)) {
        entry = location;
        return;
      }
    }
    entry = {};
    return;
  }

  String getEntryID() {
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

  List<dynamic> getLocationMap() {
    return locationsMap;
  }
}
