import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('http://127.0.0.1:8090');

String loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac odio vel purus molestie posuere. Curabitur non ante felis. Fusce volutpat turpis quis velit commodo, a tristique elit tempor. Etiam pulvinar augue ut est consectetur, in volutpat sem varius. Sed id dapibus odio. Cras ullamcorper leo quis hendrerit facilisis. Vivamus in risus euismod, pharetra elit eu, gravida lorem. Etiam dictum efficitur nulla sit amet egestas. Praesent vel mi rhoncus, gravida neque eu, elementum lorem. Integer vulputate quam nec nunc luctus aliquet. Etiam lacinia fringilla purus, vel interdum ligula aliquet vel. Mauris a lorem tempor, fermentum mauris eu, convallis lorem. Vivamus aliquet erat in laoreet efficitur. Aenean nec suscipit mi, non molestie risus. Nulla in leo at lorem porta tristique.";


class DBHandler {
  static final DBHandler _instance = DBHandler._internal();

  factory DBHandler() {
    return _instance;
  }

  DBHandler._internal();

  List<Map<String, dynamic>> fake_wikiDescription = [];

  Future<int> translateSectionToNo({required String sectionID}) async {
    // Finds takes sectionID as input and outputs section_no as an integer
    final record = await pb.collection('sections').getFirstListItem(
      'id="${sectionID}"',
      expand: 'relField1,relField2.subRelField',
    );
    return record.toJson()['section_no'];
  }

  Future<dynamic> getSectionID({required String wikiID, required int sectionNo}) async {
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

   Future<List<dynamic>> getWikis() async {
    // TODO: Implement logic to retrieve wiki information list from db
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
    // TODO: Implement logic to retrieve singular wiki title based on wiki id
    final wiki = await pb.collection('wikis').getFirstListItem(
      'id="${wikiID}"',
      expand: 'relField1,relField2.subRelField',
    );
    return wiki.toJson();
  }

  Future<String> getWikiDescription({required String wikiID}) async {
    // TODO: retrieves wiki description from the database
    final wiki = await pb.collection('wikis').getFirstListItem(
      'id="${wikiID}"',
      expand: 'relField1,relField2.subRelField',
    );
    return wiki.toJson()['wiki_description'];
  }

  Future<List<dynamic>> getCharacters({required String wikiID}) async {
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb.collection('characters').getFullList(
      sort: '-created',
      filter: 'wiki_id.id="${wikiID}"'
    );
    var recordList = [];
    for (var record in records){
      recordList.add(record.toJson());
    }
    return recordList;
  }

  //NOT TESTED YET BUT 99% SURE IT's WORKING
  Future<List<dynamic>> getLocations({required String wikiID}) async {
    // TODO: Implement logic to retrieve locations list from db
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb.collection('locations').getFullList(
        sort: '-created',
        filter: 'wiki_id.id="${wikiID}"'
    );
    var recordList = [];
    for (var record in records){
      recordList.add(record.toJson());
    }
    return recordList;
  }

  Future<List<dynamic>> getSections({required String wikiID}) async {
    // TODO: Implement logic to retrieve sections list from db
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb.collection('sections').getFullList(
        sort: '-created',
        filter: 'wiki_id.id="${wikiID}"'
    );
    var recordList = [];
    for (var record in records){
      recordList.add(record.toJson());
    }
    return recordList;
  }

  Future<List<dynamic>> getCharacterDetails(
      {required int section_no, required String characterID}) async {
    //Retrieves all details about a specific character based on series location and character id
    final records = await pb.collection('character_details').getFullList(
        sort: '-created',
        filter: 'character_id.id = "${characterID}" && section_id.section_no<="${section_no}"',
        expand: 'section_id'
    );
    var detailsList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id":"${newRecord["id"]}",
        "details_description":"${newRecord["details_description"]}",
        "character_id":"${newRecord["character_id"]}",
        "section_name":"${newRecord["expand"]["section_id"]["section_name"]}",
        "section_no":"${newRecord["expand"]["section_id"]["section_no"]}",
        "section_id":"${newRecord["section_id"]}"
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
        filter: 'location_id.id = "${locationID}" && section_id.section_no<="${section_no}"',
        expand: 'section_id'
    );
    var detailsList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id":"${newRecord["id"]}",
        "details_description":"${newRecord["details_description"]}",
        "location_id":"${newRecord["location_id"]}",
        "section_name":"${newRecord["expand"]["section_id"]["section_name"]}",
        "section_no":"${newRecord["expand"]["section_id"]["section_no"]}",
        "section_id":"${newRecord["section_id"]}"
      };
      detailsList.add(newMap);
    }
    return detailsList;
  }

  Future<List<dynamic>> getSectionDetails({required int section_no, required String wiki_id}) async {
    //Retrieves all details about a specific section based on the section number inputted
    final records = await pb.collection('section_details').getFullList(
        sort: '-created',
        filter: 'section_id.wiki_id ="${wiki_id}" && section_id.section_no<="${section_no}"',
        expand: 'section_id'
    );
    var detailsList = [];
    //Loop to format and prettify output for easy front-end use
    for (var record in records) {
      var newRecord = record.toJson();
      var newMap = {
        "id":"${newRecord["id"]}",
        "details_description":"${newRecord["details_description"]}",
        "section_name":"${newRecord["expand"]["section_id"]["section_name"]}",
        "section_no":"${newRecord["expand"]["section_id"]["section_no"]}",
        "section_id":"${newRecord["section_id"]}"
      };
      detailsList.add(newMap);
    }
    return detailsList;
  }

  void addWiki({required String wiki_name, required int wiki_section_count, required String wiki_description}) async {
    final body = <String, dynamic>{
      "wiki_name": "${wiki_name}",
      "wiki_admin": null,
      "wiki_section_count": wiki_section_count,
      "wiki_description": "${wiki_description}"
    };
    print("Creating new wiki...");
    try{
      final record = await pb.collection('wikis').create(body: body);
      print("Wiki Successfully created");
    } catch (e) {
      print(e);
    }
  }
}

void main() async {
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

  DBHandler().addWiki(wiki_name: "Star Wars", wiki_section_count: 9, wiki_description: "Covers the star wars movies 1-9");
}
