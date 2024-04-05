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
  late List<dynamic> users = [];
  late List<dynamic> verificationRequests = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _fetchVerificationRequests();
  }

  Future<void> _fetchUsers() async {
    final dbHandler = DBHandler();
    final dbUsers = await dbHandler.getUsers();
    setState(() {
      users = dbUsers;
    });
  }

  Future<void> _fetchVerificationRequests() async {
    final dbHandler = DBHandler();
    final dbVerificationRequests = await dbHandler.getVerificationRequests(
        wiki_id: widget.wikiMap['wiki_id']);
    setState(() {
      verificationRequests = dbVerificationRequests;
    });
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              TwoLineTitle(
                  firstLineText: wikiTitle,
                  secondLineText: "Verification Requests",
                  height: 150,
                  purple: 1),
              mediumSizedBox,
              SingleChildScrollView(
                child: _VerificationPane(),
              ),
            ],
          ),
        ),
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
    final EdgeInsets sideMargins = global.sideMargins;
    const EdgeInsets columnMargins = EdgeInsets.symmetric(horizontal: 5);
    const double iconSize = 30;
    final SizedBox smallSizedBox = global.smallSizedBox;
    final TextEditingController submittedUserController =
        TextEditingController();
    final TextEditingController editTypeController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
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
        ),
        smallSizedBox,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: background['500']!),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: columnMargins,
                child: Row(
                  children: [
                    const Text("Submitted by: "),
                    Expanded(
                      child: TextField(
                        controller: submittedUserController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
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
                    const Text("Edit Type: "),
                    Expanded(
                      child: TextField(
                        controller: editTypeController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
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
      ],
    );
  }
}
