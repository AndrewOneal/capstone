import 'package:code/models/book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

const String BOOK_COLLECTION_REF = "Book";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _bookRef;
  
  DatabaseService(){
    _bookRef =
        _firestore.collection(BOOK_COLLECTION_REF).withConverter<Book>(
            fromFirestore: (snapshots, _) => Book.fromJson(snapshots.data()!,),
            toFirestore: (Book, _) => Book.toJson()
        );
  }

  Stream<QuerySnapshot> getBooks(){
    return _bookRef.snapshots();
  }

  void addBook(Book book) async {
    _bookRef.add(book);
  }
}