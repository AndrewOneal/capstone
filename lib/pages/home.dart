import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('App Bar Text'),
      ),
      body: Text(
        'Mom And Dad',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
