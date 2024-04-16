import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';

class EditLocationDetails extends StatefulWidget {
  final Map<String, dynamic> wikiMap;
  final List<dynamic> locationMap;
  final String locationName;
  final int maxSectionNo;
  final String locationID;

  const EditLocationDetails({
    super.key,
    required this.wikiMap,
    required this.locationMap,
    required this.locationName,
    required this.maxSectionNo,
    required this.locationID,
  });

  @override
  EditLocationDetailsState createState() => EditLocationDetailsState();
}

class EditLocationDetailsState extends State<EditLocationDetails> {
  @override
  Widget build(BuildContext context) {
    final LocationHandler locationHandler =
        LocationHandler(locationMap: widget.locationMap);
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
                TwoLineTitle(
                    firstLineText: "Edit Location Details",
                    secondLineText: widget.locationName,
                    height: 200),
                SingleChildScrollView(
                  child: _EditLocationDetailsForm(
                    wikiMap: widget.wikiMap,
                    locationHandler: locationHandler,
                    locationName: widget.locationName,
                    maxSectionNo: widget.maxSectionNo,
                    locationID: widget.locationID,
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

class _EditLocationDetailsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonForEditController;
  final Map<String, dynamic> wikiMap;
  final LocationHandler locationHandler;
  final String locationName;
  final int maxSectionNo;
  final String locationID;

  _EditLocationDetailsForm({
    required this.wikiMap,
    required this.locationHandler,
    required this.locationName,
    required this.maxSectionNo,
    required this.locationID,
  }) : _reasonForEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final SizedBox largeSizedBox = global.largeSizedBox;
    final SizedBox extraLargeSizedBox = global.extraLargeSizedBox;
    final wikiID = wikiMap['id'];
    final SectionNoHandler sectionNoHandler = SectionNoHandler();
    sectionNoHandler.setWikiID(wikiID);
    final DBHandler dbHandler = DBHandler();
    QuillEditorManager quillEditor = QuillEditorManager();
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
        String entryID = locationHandler.getEntryID();
        String sectionID = sectionNoHandler.getSectionID();
        String editType =
            entryID.isEmpty ? "createLocationDetail" : "editLocationDetail";
        dbHandler.createVerificationRequest(
          submitterUserID: pb.authStore.model.id,
          wikiID: wikiID,
          requestPackage: {
            "editType": editType,
            "locationID": locationID,
            "sectionID": sectionID,
            "entryID": entryID,
            "updatedEntry": quillEditor.getDocumentJson(),
            "reason": _reasonForEditController.text,
          },
        );
      },
    );

    final Widget deleteButton = DarkButton(
      buttonText: "Delete Entry",
      buttonWidth: buttonWidth,
      onPressed: () {
        String entryID = locationHandler.getEntryID();
        String sectionID = sectionNoHandler.getSectionID();
        entryID.isEmpty
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
                    "editType": "deleteLocationDetail",
                    "locationID": locationID,
                    "sectionID": sectionID,
                    "entryID": entryID,
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
          _SectionDropdown(
            wikiID: wikiID,
            sectionNoHandler: sectionNoHandler,
            quillEditor: quillEditor,
            locationHandler: locationHandler,
            maxSectionNo: maxSectionNo,
          ),
          quillEditor.buildEditor(),
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

class _SectionDropdown extends StatefulWidget {
  final String wikiID;
  final SectionNoHandler sectionNoHandler;
  final QuillEditorManager quillEditor;
  final LocationHandler locationHandler;
  final int maxSectionNo;

  const _SectionDropdown(
      {required this.wikiID,
      required this.sectionNoHandler,
      required this.quillEditor,
      required this.locationHandler,
      required this.maxSectionNo});

  @override
  _SectionDropdownState createState() => _SectionDropdownState();
}

class _SectionDropdownState extends State<_SectionDropdown> {
  late List<dynamic> sections;
  late int sectionNo = 1;
  late List<Map<String, dynamic>> description = [
    {"insert": "\n"}
  ];

  @override
  void initState() {
    super.initState();
    sections = [];
    description = widget.locationHandler.getDescriptionFromSection(sectionNo);
    widget.quillEditor.setInput(description);
    fetchSections();
    widget.sectionNoHandler.setSectionID();
  }

  Future<void> fetchSections() async {
    DBHandler dbHandler = DBHandler();
    List fetchedSections = await dbHandler.getSections(wikiID: widget.wikiID);
    setState(() {
      sections = fetchedSections;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: sectionNo,
      isExpanded: true,
      onChanged: (index) {
        setState(() {
          sectionNo = index!;
          widget.sectionNoHandler.setSectionNo(sectionNo);

          description =
              widget.locationHandler.getDescriptionFromSection(sectionNo);

          widget.quillEditor.setInput(description);

          widget.sectionNoHandler.setSectionID();
        });
      },
      items: sections
          .where((section) => section['section_no'] <= widget.maxSectionNo)
          .map<DropdownMenuItem<int>>((section) {
        final sectionNo = section['section_no'];
        final sectionName = section['section_name'];
        return DropdownMenuItem<int>(
          value: sectionNo,
          child: Text(sectionName, style: TextStyles.listText),
        );
      }).toList(),
    );
  }
}

class SectionNoHandler {
  late int sectionNo = 1;
  final DBHandler dbHandler = DBHandler();
  late String sectionID = '';
  late String wikiID = '';

  SectionNoHandler();

  int getSectionNo() {
    return sectionNo;
  }

  void setSectionNo(int newSectionNo) {
    sectionNo = newSectionNo;
  }

  Future<void> setSectionID() async {
    sectionID =
        await dbHandler.getSectionID(sectionNo: sectionNo, wikiID: wikiID);
  }

  String getSectionID() {
    return sectionID;
  }

  void setWikiID(String newWikiID) {
    wikiID = newWikiID;
  }
}

class LocationHandler {
  final List<dynamic> locationMap;
  Map<String, dynamic> entry = {};

  LocationHandler({required this.locationMap});

  void setEntryFromSection(int sectionNo) {
    for (Map<String, dynamic> location in locationMap) {
      final locationSectionNo = int.tryParse(location['section_no'].toString());
      if (locationSectionNo == sectionNo) {
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

  List<Map<String, dynamic>> getDescriptionFromSection(int sectionNo) {
    setEntryFromSection(sectionNo);
    if (entry.isNotEmpty) {
      return (entry['details_description']['flutter_quill'] as List)
          .cast<Map<String, dynamic>>();
    }
    return [
      {"insert": "\n"}
    ];
  }

  List<dynamic> getLocationMap() {
    return locationMap;
  }
}
