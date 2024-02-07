import 'dart:async';
import 'dart:convert';
import 'package:code/utilities/firebase_utilities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as logDev;
import 'package:code/utilities/pocketbase_utilities.dart';
import 'package:code/CharacterCard.dart';
import 'dart:math' as math;

final pb = PocketBase('http://127.0.0.1');

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  late Future<List> characterFutureData;
  @override
  void initState() {
    super.initState();
    characterFutureData = PBHelper.getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character List:"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: characterFutureData,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if(snapshot.hasError){
              logDev.log("ERROR WITH Acquiring Data", name: "ListViewLog");
              return Text("There was an Error");
            } else if (snapshot.hasData){
              //logDev.log("${PBHelper.toJsonObject(snapshot.data![0])['name']}", name: "ListViewLog");
              return ListView.separated(
                separatorBuilder: (BuildContext context, index) {
                  return SizedBox(height: 5);
                },
                padding: EdgeInsets.all(7),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  logDev.log("${PBHelper.toJsonObject(snapshot.data![0])['id']}", name: "ParameterLog");
                  return ListTile(
                    leading: Icon(Icons.shield_moon_rounded),
                    title: Text("${PBHelper.toJsonObject(snapshot.data![index])['name']}"),
                    trailing: Icon(Icons.wind_power),
                    tileColor: Colors.pink.shade100,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/characterDetails',
                        arguments: {"characterID": PBHelper.toJsonObject(snapshot.data![index])['id'], "name": PBHelper.toJsonObject(snapshot.data![index])['name']}
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                    ),
                  );
                },
              );
            } else {
              //logDev.log("${snapshot.data}", name: "ListViewLog");
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {});
        },
      ),
    );
  }
}

