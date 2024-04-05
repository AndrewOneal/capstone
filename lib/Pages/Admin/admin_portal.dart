import 'package:flutter/material.dart';
import 'package:capstone/Utilities/global.dart';
import 'package:capstone/Utilities/db_util.dart';
import 'package:capstone/Pages/Admin/verification.dart';
import 'dart:convert';

class AdminPortal extends StatelessWidget {
  final List<dynamic> adminWikis;

  const AdminPortal({super.key, required this.adminWikis});

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
                firstLineText: '$username\'s',
                secondLineText: "Admin Portal",
                purple: 1),
            mediumSizedBox,
            Expanded(
              child: _AdminList(
                adminWikis: adminWikis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminList extends StatelessWidget {
  final List<dynamic> adminWikis;
  const _AdminList({required this.adminWikis});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: adminWikis.length + 1,
      separatorBuilder: (BuildContext context, int index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Divider(),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == adminWikis.length) {
          return Padding(
            padding: const EdgeInsets.only(right: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 100),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Select your wiki to approve or deny pending verification requests.",
                        style: TextStyles.disclaimerText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return index.isEven
              ? LightPurpleButton2(
                  buttonText: adminWikis[index]['wiki_name'],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationPage(
                          wikiMap: adminWikis[index],
                        ),
                      ),
                    );
                  },
                )
              : LightPurpleButton1(
                  buttonText: adminWikis[index]['wiki_name'],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationPage(
                          wikiMap: adminWikis[index],
                        ),
                      ),
                    );
                  },
                );
        }
      },
    );
  }
}
