import 'dart:convert';

import 'package:code/utilities/pocketbase_utilities.dart';
import 'package:pocketbase/pocketbase.dart';
import 'dart:developer' as logDev;

final pb = PocketBase('http://127.0.0.1:8090');

Future<void> main() async {
  print("Testing print");
  Object title = await PBHelper.getCharacterByID("fs01b4jo305adrl");
  //var characterDetails = PBHelper.getDescriptionByCharacterID(args);
  //signUp();
  final characterList = await PBHelper.getAllCharacters();
  print(await PBHelper.getDescriptionByCharacterID("fs01b4jo305adrl"));
  //rint(json.decode(title.toString())['id']);
}

