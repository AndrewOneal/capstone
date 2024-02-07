import 'dart:async';
import 'package:code/utilities/firebase_utilities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as logDev;
import 'package:code/utilities/pocketbase_utilities.dart';
import 'package:code/pages/characters.dart';
import 'package:code/pages/characterDetails.dart';

final pb = PocketBase('http://127.0.0.1');

var db = FirebaseFirestore.instance;
var _databaseService = DatabaseService();

// Future<List<RecordModel>> getFullPeople() async {
// // you can also fetch all records at once via getFullList
//   final records = await pb.collection('People').getFullList(
//     sort: '-created',
//   );
//   return records;
// }

void main() async {
  //Firebase testing and initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  // logDev.log("Is the Logger working now", name: "myLog");
  // await db.collection('Book').get().then((event) {
  //   for (var doc in event.docs) {
  //     logDev.log("${doc.id} => ${doc.data()}", name: "DataLog");
  //     if (doc.data() is String){
  //       logDev.log("Data is a string");
  //     }
  //   }
  // });

  var records = await PBHelper.getAllRecords();
  logDev.log("${records}", name: "PocketBaseLog");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '/characters':(context) => const CharactersPage(),
        '/characterDetails':(context) => const CharacterDetailsPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> books =
      FirebaseFirestore.instance.collection('Book').snapshots();

  String dropdwonValue = 'One';

  late Future<dynamic> dataFuture;
  @override void initState(){
    super.initState();
    dataFuture = PBHelper.getAllRecords();
  }

  var records = PBHelper.getAllRecords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Avatar The Last Airbender",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.pink.shade100,
        ),
        body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Center(
              child: FilledButton(
                child: const Text('Characters'),
                onPressed: (){
                  Navigator.pushNamed(context, '/characters');
                },
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: FilledButton(
                child: const Text('Summaries'),
                onPressed: (){
                  Navigator.pushNamed(context, '/characters');
                },
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: DropdownButton<String>(
                value: dropdwonValue,
                icon: const Icon(Icons.menu),
                items: [
                  DropdownMenuItem(
                    child: Text('Season One'),
                    value: 'One'
                  ),
                  DropdownMenuItem(
                      child: Text('Season Two'),
                      value: 'Two'
                  ),
                  DropdownMenuItem(
                      child: Text('Season Three'),
                      value: 'Three'
                  )
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    dropdwonValue = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
