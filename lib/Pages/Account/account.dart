import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Pages/wiki_list.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Admin/admin_portal.dart';
import 'dart:convert';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late List<dynamic> wikiAdmin = [];

  @override
  void initState() {
    super.initState();
    _fetchAdminWikis();
  }

  Future<void> _fetchAdminWikis() async {
    final dbHandler = DBHandler();
    final details = await dbHandler.getWikis();
    setState(() {
      wikiAdmin = checkForAdmin(details);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Global global = Global();
    final EdgeInsets sideMargins = global.sideMargins;
    final SizedBox mediumSizedBox = global.mediumSizedBox;
    final String username =
        json.decode(pb.authStore.model.toString())['username'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WikiListPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: sideMargins,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TwoLineTitle(
                  firstLineText: "Welcome Back", secondLineText: username),
              DarkButton(
                buttonText: "Logout",
                onPressed: () {
                  pb.authStore.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WikiListPage()),
                  );
                },
              ),
              mediumSizedBox,
              wikiAdmin.isNotEmpty
                  ? DarkButton(
                      buttonText: "Admin Panel",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminPortal(
                                    adminWikis: wikiAdmin,
                                  )),
                        );
                      })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

List<dynamic> checkForAdmin(List<dynamic> wikiTitles) {
  final String userID = pb.authStore.model.id;
  List<dynamic> adminWikis = [];
  for (int i = 0; i < wikiTitles.length; i++) {
    if (wikiTitles[i]['wiki_admin'].toString().contains(userID)) {
      adminWikis.add(wikiTitles[i]);
    }
  }
  return adminWikis;
}
