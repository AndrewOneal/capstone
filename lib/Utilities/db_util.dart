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

  Future<Map<String, dynamic>> getWiki({required String wiki_id}) async {
    // TODO: Implement logic to retrieve singular wiki title based on wiki id
    final wiki = await pb.collection('wikis').getFirstListItem(
      'id="${wiki_id}"',
      expand: 'relField1,relField2.subRelField',
    );
    return wiki.toJson();
  }

  Future<String> getWikiDescription({required String wiki_id}) async {
    // TODO: retrieves wiki description from the database
    final wiki = await pb.collection('wikis').getFirstListItem(
      'id="${wiki_id}"',
      expand: 'relField1,relField2.subRelField',
    );
    return wiki.toJson()['wiki_description'];
  }

  Future<List<dynamic>> getCharacters({required String wiki_id}) async {
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb.collection('characters').getFullList(
      sort: '-created',
      filter: 'wiki_id.id="${wiki_id}"'
    );
    var recordList = [];
    for (var record in records){
      recordList.add(record.toJson());
    }
    return recordList;
  }

  //NOT TESTED YET BUT 99% SURE IT's WORKING
  Future<List<dynamic>> getLocations({required String wiki_id}) async {
    // TODO: Implement logic to retrieve locations list from db
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb.collection('locations').getFullList(
        sort: '-created',
        filter: 'wiki_id.id="${wiki_id}"'
    );
    var recordList = [];
    for (var record in records){
      recordList.add(record.toJson());
    }
    return recordList;
  }

  Future<List<dynamic>> getSections({required String wiki_id}) async {
    // TODO: Implement logic to retrieve sections list from db
    // TODO: Retrieves all characters associated with a specific wiki
    final records = await pb.collection('sections').getFullList(
        sort: '-created',
        filter: 'wiki_id.id="${wiki_id}"'
    );
    var recordList = [];
    for (var record in records){
      recordList.add(record.toJson());
    }
    return recordList;
  }

  Map<String, List<Map<String, dynamic>>> getCharacterDetails(
      {required int wikiID,
        required int wikiSectionID,
        required int wikiCharacterID}) {
    // Retrieves all character details related to a specific wiki part and specific character


    return {
      "Header 1": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
      "Header 2": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
      "Header 3": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
    };
  }

  Map<String, List<Map<String, dynamic>>> getSectionDetails(
      {required int wikiID,
      required int wikiSettingID,
      required int wikiDetailID}) {
    // TODO: Implement logic to retrieve wiki details page from db


    return {
      "Header 1": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
      "Header 2": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
      "Header 3": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
    };
  }

  Map<String, List<Map<String, dynamic>>> getLocationDetails(
      {required int wikiID,
        required int wikiSettingID,
        required int wikiDetailID}) {
    // TODO: Implement logic to retrieve wiki details page from db


    return {
      "Header 1": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
      "Header 2": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
      "Header 3": [
        {
          "insert": loremIpsum,
        },
        {
          "insert": "\n",
        }
      ],
    };
  }

  void addWiki(
      {required String title,
      required String sectionsName,
      required int wiki_section_count,
      required List<Map<String, dynamic>> description}) {
    // TODO: Implement logic to add a wiki to db
    fake_wikiDescription = description;
  }
}

void main() async {
  print("Wiki List: \n");
  var data = await DBHandler().getSections(wiki_id: "9tk9j8x06yrcy9f");
  print(data);
  print("-------------------------------------------");
}
