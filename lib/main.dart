import 'package:code/utilities/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as logDev;

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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  logDev.log("Is the Logger working now", name: "myLog");
  await db.collection('Book').get().then((event) {
    for (var doc in event.docs) {
      logDev.log("${doc.id} => ${doc.data()}", name: "DataLog");
    }
  });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
          backgroundColor: Colors.blue,
        ),
        body: _buildUI());
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Read Info from cloud Firestore',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Testing Data"
            ),
          ),
        ],
      ),
    );
  }

// Widget bookListView() {
//   return SizedBox(
//     height: MediaQuery.sizeOf(context).height * 0.80,
//     width: MediaQuery.sizeOf(context).width,
//     child: StreamBuilder(builder: (context, snapshot) {
//       return ListView();
//     }, stream: _databaseService.getBooks,),
//   );
// }
}
