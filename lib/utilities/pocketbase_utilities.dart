import 'dart:convert';

import 'package:pocketbase/pocketbase.dart';
import 'dart:developer' as logDev;

final pb = PocketBase('http://127.0.0.1:8090');

class PBHelper {
  static Map toJsonObject(var item){
    return json.decode(item.toString());
  }

  //CHARACTER TABLE FUNCTIONS:
  static Future<List> getAllRecords() async {
    final records = await pb.collection('Books').getFullList();
    return records;
  }
  //Gets list of all characters
  static Future<List> getAllCharacters() async {
    final records = await pb.collection('Characters').getFullList();
    return records;
  }

  //Gets specific character by name
  static Future<Object> getCharacterByName(String name) async {
    final record = await pb.collection('Characters').getFirstListItem(
      'Name="${name}"',
    );
    return record;
  }
  static Future<Object> getCharacterByID(String id) async {
    final record = await pb.collection('Characters').getFirstListItem(
      'id="${id}"',
    );
    return record;
  }


  //DESCRIPTION TABLE FUNCTIONS:
  // or fetch only the first record that matches the specified filter
  static Future<Object> getDescriptionByCharacterID(String id) async {
    final record = await pb.collection('Descriptions').getFirstListItem(
      'CharacterID="${id}"',
    );
    return record;
  }




  //SERIES  TABLE FUNCTIONS:
}