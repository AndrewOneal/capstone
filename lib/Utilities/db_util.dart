import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');

String loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac odio vel purus molestie posuere. Curabitur non ante felis. Fusce volutpat turpis quis velit commodo, a tristique elit tempor. Etiam pulvinar augue ut est consectetur, in volutpat sem varius. Sed id dapibus odio. Cras ullamcorper leo quis hendrerit facilisis. Vivamus in risus euismod, pharetra elit eu, gravida lorem. Etiam dictum efficitur nulla sit amet egestas. Praesent vel mi rhoncus, gravida neque eu, elementum lorem. Integer vulputate quam nec nunc luctus aliquet. Etiam lacinia fringilla purus, vel interdum ligula aliquet vel. Mauris a lorem tempor, fermentum mauris eu, convallis lorem. Vivamus aliquet erat in laoreet efficitur. Aenean nec suscipit mi, non molestie risus. Nulla in leo at lorem porta tristique.";

class DBHandler {
  static final DBHandler _instance = DBHandler._internal();

  factory DBHandler() {
    return _instance;
  }

  DBHandler._internal();

  Future<int> translateSectionToNo({required String sectionID}) async {
    // Finds takes sectionID as input and outputs section_no as an integer
    final record = await pb.collection('sections').getFirstListItem(
          'id="${sectionID}"',
          expand: 'relField1,relField2.subRelField',
        );
    return record.toJson()['section_no'];
  }

  Future<dynamic> getSectionID(
      {required String wikiID, required int sectionNo}) async {
    //retrieves section ID from settings by utilizing wikiID & section number
    final record = await pb.collection('sections').getFirstListItem(
          'wiki_id.id="${wikiID}" && section_no="${sectionNo}"',
          expand: 'relField1,relField2.subRelField',
        );
    var sectionID = record.toJson()['id'];
    return sectionID;
  }

  Future<String> getCharacterName({required String characterID}) async {
    final record = await pb.collection('characters').getFirstListItem(
          'id="${characterID}"',
          expand: 'relField1,relField2.subRelField',
        );
    return record.toJson()['name'];
  }

  Future<String> getCharacterIDFromName(
      {required String characterName, required String wikiID}) async {
    final record = await pb
        .collection('characters')
        .getFirstListItem('name~"$characterName" && wiki_id.id="$wikiID"');
    return record.toJson()['id'];
  }

  Future<String> getWikiIDFromName({required String wikiName}) async {
    final record =
        await pb.collection('wikis').getFirstListItem('wiki_name~"$wikiName"');
    return record.toJson()['id'];
  }

  Future<String> getLocationIDFromName({required String locationName}) async {
    final record = await pb
        .collection('locations')
        .getFirstListItem('name~"$locationName"');
    return record.toJson()['id'];
  }

  Future<List<dynamic>> getUsers() async {
    var users = await pb.collection('users').getFullList(
          sort: '-created',
        );
    var userList = [];
    for (var element in users) {
      userList.add(element.toJson());
    }
    return userList;
  }

  Future<List<dynamic>> getUserIDList() async {
    var users = await pb.collection('users').getFullList(
          sort: '-created',
        );
    var userIDList = [];
    for (var element in users) {
      userIDList.add(element.toJson()['id']);
    }
    return userIDList;
  }

  Future<List<dynamic>> getWikis() async {
    var wikis = await pb.collection('wikis').getFullList(
          sort: '-created',
        );
    var wikiList = [];
    for (var element in wikis) {
      wikiList.add(element.toJson());
    }
    return wikiList;
  }

  Future<Map<String, dynamic>> getWiki({required String wikiID}) async {
    final wiki = await pb.collection('wikis').getFirstListItem(
          'id="${wikiID}"',
          expand: 'relField1,relField2.subRelField',
        );
    return wiki.toJson();
  }

  Future<String> getWikiDescription({required String wikiID}) async {
    final wiki = await pb.collection('wikis').getFirstListItem(
          'id="${wikiID}"',
          expand: 'relField1,relField2.subRelField',
        );
    return wiki.toJson()['wiki_description'];
  }

  Future<List<dynamic>> getCharacters({required String wikiID}) async {
    final records = await pb
        .collection('characters')
        .getFullList(sort: '-created', filter: 'wiki_id.id="${wikiID}"');
    var recordList = [];
    for (var record in records) {
      recordList.add(record.toJson());
    }
    return recordList;
  }

  //NOT TESTED YET BUT 99% SURE IT's WORKING
  Future<List<dynamic>> getLocations({required String wikiID}) async {
    // TODO: Implement logic to retrieve locations list from db
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb
        .collection('locations')
        .getFullList(sort: '-created', filter: 'wiki_id.id="${wikiID}"');
    var recordList = [];
    for (var record in records) {
      recordList.add(record.toJson());
    }
    return recordList;
  }

  Future<List<dynamic>> getSections({required String wikiID}) async {
    // TODO: Implement logic to retrieve sections list from db
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb
        .collection('sections')
        .getFullList(sort: '-created', filter: 'wiki_id.id="${wikiID}"');
    var recordList = [];
    for (var record in records) {
      recordList.add(record.toJson());
    }
    return recordList;
  }

  Future<List<dynamic>> getCharacterDetails(
      {required int section_no, required String characterID}) async {
    //Retrieves all details about a specific character based on series location and character id
    final records = await pb.collection('character_details').getFullList(
        sort: '-created',
        filter:
            'character_id.id = "${characterID}" && section_id.section_no<="${section_no}"',
        expand: 'section_id');
    var detailsList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id": "${newRecord["id"]}",
        "details_description": "${newRecord["details_description"]}",
        "character_id": "${newRecord["character_id"]}",
        "section_name": "${newRecord["expand"]["section_id"]["section_name"]}",
        "section_no": "${newRecord["expand"]["section_id"]["section_no"]}",
        "section_id": "${newRecord["section_id"]}"
      };
      detailsList.add(newMap);
    }
    return detailsList;
  }

  Future<List<dynamic>> getLocationDetails(
      {required int section_no, required String locationID}) async {
    //Retrieves all details about a specific location based location id and section number
    final records = await pb.collection('location_details').getFullList(
        sort: '-created',
        filter:
            'location_id.id = "${locationID}" && section_id.section_no<="${section_no}"',
        expand: 'section_id');
    var detailsList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id": "${newRecord["id"]}",
        "details_description": "${newRecord["details_description"]}",
        "location_id": "${newRecord["location_id"]}",
        "section_name": "${newRecord["expand"]["section_id"]["section_name"]}",
        "section_no": "${newRecord["expand"]["section_id"]["section_no"]}",
        "section_id": "${newRecord["section_id"]}"
      };
      detailsList.add(newMap);
    }
    return detailsList;
  }

  Future<List<dynamic>> getSectionDetails(
      {required int section_no, required String wiki_id}) async {
    //Retrieves all details about a specific section based on the section number inputted
    final records = await pb.collection('section_details').getFullList(
        sort: '-created',
        filter:
            'section_id.wiki_id ="${wiki_id}" && section_id.section_no="${section_no}"',
        expand: 'section_id');
    var detailsList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id": "${newRecord["id"]}",
        "details_description": "${newRecord["details_description"]}",
        "section_name": "${newRecord["expand"]["section_id"]["section_name"]}",
        "section_no": "${newRecord["expand"]["section_id"]["section_no"]}",
        "section_id": "${newRecord["section_id"]}"
      };
      detailsList.add(newMap);
    }
    return detailsList;
  }

  Future<List<dynamic>> getVerificationRequests({required wiki_id}) async {
    //Retrieves all verification requests for a specific wiki
    final records = await pb
        .collection('verification_requests')
        .getFullList(sort: '-created', filter: 'wiki_id ="${wiki_id}"');
    var verificationList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id": "${newRecord["id"]}",
        "submitter_user_id": "${newRecord["submitter_user_id"]}",
        "wiki_id": "${newRecord["wiki_id"]}",
        "request_package": "${newRecord["request_package"]}"
      };
      verificationList.add(newMap);
    }
    return verificationList;
  }

  Future<void> createWiki(
      {required String wiki_name,
      required int wiki_section_count,
      required String wiki_description,
      required String section_name}) async {
    //Create new wiki record
    final body = <String, dynamic>{
      "wiki_name": "${wiki_name}",
      "wiki_admin": null,
      "wiki_section_count": wiki_section_count,
      "wiki_description": "${wiki_description}"
    };
    print("Creating new wiki...");
    try {
      final record = await pb.collection('wikis').create(body: body);
      print("Wiki Successfully created");
      print("Creating new sections for wiki...");
      for (var i = 1; i <= wiki_section_count; i++) {
        DBHandler().createSection(
            section_name: "${section_name} ${i}",
            associated_wiki_id:
                await DBHandler().getWikiIDFromName(wikiName: wiki_name),
            section_no: i);
      }
      print("${wiki_section_count} sections created for ${wiki_name} wiki");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createCharacter(
      {required String character_name,
      required String associated_wiki_id,
      nickname}) async {
    if (nickname != String) {
      nickname = "";
    }
    // Create new character record
    final body = <String, dynamic>{
      "name": "${character_name}",
      "nickname": "${nickname}",
      "wiki_id": ["${associated_wiki_id}"]
    };
    try {
      print("Creating Character...");
      final record = await pb.collection('characters').create(body: body);
      print("New Character successfully created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createCharacterDetail(
      {required String details_description,
      required String associated_character_id,
      required String associated_section_id}) async {
    // Create new character detail record
    final body = <String, dynamic>{
      "details_description": "${details_description}",
      "character_id": "${associated_character_id}",
      "section_id": "${associated_section_id}"
    };
    try {
      print("Creating new character detail...");
      final record =
          await pb.collection('character_details').create(body: body);
      print("New character detail succesfully created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createLocation(
      {required String location_name,
      required String associated_wiki_id}) async {
    // Create new location record
    final body = <String, dynamic>{
      "name": "${location_name}",
      "wiki_id": ["${associated_wiki_id}"]
    };
    try {
      print("Creating Location...");
      final record = await pb.collection('locations').create(body: body);
      print("New location successfully created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createLocationDetail(
      {required String details_description,
      required String associated_location_id,
      required String associated_section_id}) async {
    // Create new location detail record
    final body = <String, dynamic>{
      "details_description": "${details_description}",
      "location_id": "${associated_location_id}",
      "section_id": "${associated_section_id}"
    };
    try {
      print("Creating new location detail...");
      final record = await pb.collection('location_details').create(body: body);
      print("New location detail succesfully created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createSection(
      {required String section_name,
      required String associated_wiki_id,
      required int section_no}) async {
    // Create new section record
    final body = <String, dynamic>{
      "section_name": "${section_name}",
      "wiki_id": "${associated_wiki_id}",
      "section_no": section_no
    };
    try {
      print("Creating new section...");
      final record = await pb.collection('sections').create(body: body);
      print("New section successfully created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createSectionDetail(
      {required String details_description,
      required String associated_section_id}) async {
    // Create new section detail record
    final body = <String, dynamic>{
      "details_description": "${details_description}",
      "section_id": "${associated_section_id}"
    };
    try {
      print("Creating new section detail...");
      final record = await pb.collection('section_details').create(body: body);
      print("New section detail succesfully created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> createVerificationRequest(
      {required String submitterUserID,
      required String wikiID,
      required requestPackage}) async {
    //Create new verification request record
    final body = <String, dynamic>{
      "submitter_user_id": submitterUserID,
      "wiki_id": wikiID,
      "request_package": "${requestPackage}"
    };
    try {
      print("Creating new verification request...");
      final record =
          await pb.collection('verification_requests').create(body: body);
      print("New verification requests created");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteWiki({required String wikiID}) async {
    try {
      await pb.collection('wikis').delete('${wikiID}');
      print("Succesfully deleted wiki");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCharacter({required String characterID}) async {
    try {
      await pb.collection('characters').delete('${characterID}');
      print("Succesfully deleted character");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteLocation({required String locationID}) async {
    try {
      await pb.collection('locations').delete('${locationID}');
      print("Succesfully deleted location");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteSection({required String sectionID}) async {
    try {
      await pb.collection('sections').delete('${sectionID}');
      print("Succesfully deleted section");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCharacterDetail(
      {required String characterDetailID}) async {
    try {
      await pb.collection('character_details').delete('${characterDetailID}');
      print("Succesfully deleted character detail");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteLocationDetail({required String locationDetailID}) async {
    try {
      await pb.collection('location_details').delete('${locationDetailID}');
      print("Succesfully deleted location detail");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteSectionDetail({required String sectionDetailID}) async {
    try {
      await pb.collection('section_details').delete('${sectionDetailID}');
      print("Succesfully deleted section detail");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteVerificationRequests(
      {required String verification_record_id}) async {
    try {
      await pb
          .collection('verification_requests')
          .delete('${verification_record_id}');
      print("Succesfully deleted verification request");
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> updateWiki(
      {required String wikiID,
      required String new_name,
      required String new_description}) async {
    final body = <String, dynamic>{
      "wiki_name": new_name,
      "wiki_description": new_description
    };
    try {
      var record = await pb.collection('wikis').update(wikiID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<Map<String, dynamic>> updateCharacter(
      {required String characterID,
      required String new_name,
      required String new_nickname}) async {
    final body = <String, dynamic>{"name": new_name, "nickname": new_nickname};
    try {
      var record =
          await pb.collection('characters').update(characterID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<Map<String, dynamic>> updateLocation(
      {required String locationID, required String new_location_name}) async {
    final body = <String, dynamic>{
      "name": new_location_name,
    };
    try {
      var record =
          await pb.collection('locations').update(locationID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<Map<String, dynamic>> updateSection(
      {required String sectionID, required String new_section_name}) async {
    final body = <String, dynamic>{
      "section_name": new_section_name,
    };
    try {
      var record =
          await pb.collection('sections').update(sectionID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<Map<String, dynamic>> updateCharacterDetail(
      {required String characterDetailsID,
      required String new_details_description}) async {
    final body = <String, dynamic>{
      "details_description": new_details_description,
    };
    try {
      var record = await pb
          .collection('character_details')
          .update(characterDetailsID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<Map<String, dynamic>> updateLocationDetail(
      {required String locationDetailID,
      required String new_details_description}) async {
    final body = <String, dynamic>{
      "details_description": new_details_description,
    };
    try {
      var record = await pb
          .collection('location_details')
          .update(locationDetailID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<Map<String, dynamic>> updateSectionDetail(
      {required String sectionDetailID,
      required String new_details_description}) async {
    final body = <String, dynamic>{
      "details_description": new_details_description,
    };
    try {
      var record = await pb
          .collection('section_details')
          .update(sectionDetailID, body: body);
      return record.toJson();
    } catch (e) {
      return {"Error": "${e}"};
    }
  }

  Future<void> authenticate(
      {required String username, required String password}) async {
    final authData = await pb.collection('users').authWithPassword(
          '${username}',
          '${password}',
        );
  }

  Future<void> registerAccount(
      {required String username,
      required String email,
      required String password,
      required String passwordConfirm}) async {
    // Register new account
    final body = <String, dynamic>{
      "username": "${username}",
      "email": "${email}",
      "emailVisibility": true,
      "password": "${password}",
      "passwordConfirm": "${passwordConfirm}"
    };
    try {
      final record = await pb.collection('users').create(body: body);
      print("User ${username} has been registered");
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserIDFromName({required String userName}) async {
    String userID = "";
    try {
      print("Retreiving userID...");
      final record = await pb
          .collection('users')
          .getFirstListItem('username="${userName}"');
      userID = record.toJson()["id"];
    } catch (e) {
      print(e);
    }
    return userID;
  }

  Future<String> getUserIDFromEmail({required String userEmail}) async {
    String userID = "";
    try {
      print("Retreiving userID...");
      final record =
          await pb.collection('users').getFirstListItem('email="${userEmail}"');
      userID = record.toJson()["id"];
    } catch (e) {
      print(e);
    }
    return userID;
  }
}

Future<void> main() async {
  print("Wiki List: \n");
  //TODO: Stuff to test READ functionalities
  // var data = await DBHandler().getCharacterDetails(section_no: 3, characterID: 'nbxynzck218e4qq');
  // print(data);
  // var location_details = await DBHandler().getLocationDetails(section_no: 3, locationID: "9cu0atfmbsvi1di");
  // print(location_details);
  // var section_details = await DBHandler().getSectionDetails(section_no: 2, wiki_id: "ndlh8nkyr4uyjw4");
  // print(section_details);
  // var translation = await DBHandler().getCharacterName(characterID: "nbxynzck218e4qq");
  // print(translation);
  // var locations = await DBHandler().getLocations(wikiID: "ndlh8nkyr4uyjw4");
  // print(locations);
  // var characterID = await DBHandler().getWikiIDFromName(wikiName: "Avatar: The Last Airbender");
  // print(characterID);

  //DBHandler().createCharacter(character_name: "Azula", associated_wiki_id: "ndlh8nkyr4uyjw4");
  //DBHandler().createCharacterDetail(details_description: '{"String":"New detail about azula for book 1"}', associated_character_id: "h1u69fa7cq5t9a7", associated_section_id: "g8294277htd9p13");
  //DBHandler().createWiki(wiki_name: "Star Wars", wiki_section_count: 9, wiki_description: "Covers the star wars movies 1-9", section_name: 'Movie');

  //DBHandler().createLocation(location_name: "Southern Water Tribe", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Breaking"));
  //DBHandler().createLocationDetail(details_description: '{"String":"New detail about Omashu for book 3"}', associated_location_id: "jogmpljl9j6ibfu", associated_section_id: "jz7pr9z31nfadbf");

  //DBHandler().createSection(section_name: "Season 6", associated_wiki_id: "9tk9j8x06yrcy9f", section_no: 6);
  //DBHandler().createSectionDetail(details_description: '{"String":"This is a new section detail about breaking bad season 6"}', associated_section_id: "5l1b2evenu2gt8g");

  // await DBHandler().createWiki(wiki_name: "Star Wars", wiki_section_count: 9, wiki_description: "Covers the star wars movies 1-9", section_name: 'Movie');
  // await DBHandler().createCharacter(character_name: "Anakin", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Star Wars"));
  // await DBHandler().createCharacterDetail(details_description: '{"String":"New detail about Anakin from movie 2"}', associated_character_id: await DBHandler().getCharacterIDFromName(characterName: "Anakin", wikiID: await DBHandler().getWikiIDFromName(wikiName: "Star Wars")), associated_section_id: await DBHandler().getSectionID(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Star Wars"), sectionNo: 2));
  // await DBHandler().createLocation(location_name: "Coruscant", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Star Wars"));

  // await DBHandler().updateCharacter(characterID: "hhzw467jzyqqcf8", new_name: "Iroh (Zuko Uncle)", new_nickname: "Dragon of the West");
  // await DBHandler().updateLocation(locationID: "9cu0atfmbsvi1di", new_location_name: "Ba Sing Se (Earth Kingdom Capital)");
  // await DBHandler().updateSection(new_section_name: "Book 2: Earth", sectionID: '3c0t4afrp16l7zs');
  // await DBHandler().updateCharacterDetail(characterDetailsID: "tjamf8homoiwwpw", new_details_description: '{"String":"Aang discovers his people are dead in book 1 and onwawrd"}');
  // await DBHandler().updateLocationDetail(locationDetailID: "tj0ck5ike5em9k5", new_details_description: '{"String": "New detail about Omashu for book 3 and onward"}');
  // await DBHandler().updateSectionDetail(sectionDetailID: "6ats0591e6qgtbv", new_details_description: '{"String": "This is a new section detail about breaking bad season 6 and onward"}');

  //await DBHandler().authenticate(username: "admin@gmail.com", password: "admin@gmail.com");
  //await DBHandler().registerAccount(username: "TestAccount", email: "test@gmail.com", password: "test@gmail.com", passwordConfirm: "test@gmail.com");
  // await DBHandler().authenticate(username: "yes@gmail.com", password: "yes@gmail.com");
  // print(await DBHandler().getUserIDFromName(userName: "yes"));
  // print(await DBHandler().getUserIDFromEmail(userEmail: "yes@gmail.com"));

  // await DBHandler().createVerificationRequest(submitterUserID: "o21699v9hjdlo30", wikiID: "ndlh8nkyr4uyjw4", requestPackage: '{"String": "Aang discovers his people are dead in book 1 and onwawrd"}');
  print(await DBHandler().getVerificationRequests(
      wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Avatar")));
  // await DBHandler().deleteVerificationRequests(verification_record_id: "9pxaqa3dssqx3bs");
}
