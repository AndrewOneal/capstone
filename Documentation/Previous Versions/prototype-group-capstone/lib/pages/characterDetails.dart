import 'dart:async';
import 'package:code/utilities/firebase_utilities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as logDev;
import 'package:code/utilities/pocketbase_utilities.dart';
import 'package:code/CharacterCard.dart';
import 'package:flutter/cupertino.dart';

class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({super.key});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  var argsID;
  var argsName;

  late Future<dynamic> characterDetails;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if(arguments != null){
      argsID = arguments['characterID'];
      characterDetails = PBHelper.getDescriptionByCharacterID(argsID);
      argsName = arguments['name'];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${argsName}"),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: FutureBuilder(
          future: characterDetails,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Text("${PBHelper.toJsonObject(snapshot.data)['text'].toString()}", style: TextStyle(fontWeight: FontWeight.bold),);
          }
        ),
      ),
    );
  }
}
