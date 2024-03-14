class DBHandler {
  static final DBHandler _instance = DBHandler._internal();

  factory DBHandler() {
    return _instance;
  }

  DBHandler._internal();

  final List<String> titles = [
    "Avatar: The Last Airbender",
    "Darling in the Franxx",
    "Fate",
    "Friends",
    "Harry Potter",
    "How I Met Your Mother",
    "One Piece",
    "Phineas and Ferb",
    "Regular Show",
    "Spongebob",
    "The Office",
    "The Wheel of Time",
  ];

  final List<String> characters = [
    "Character 1",
    "Character 2",
    "Character 3",
    "Character 4",
    "Character 5",
    "Character 6",
    "Character 7",
    "Character 8",
    "Character 9",
    "Character 10",
  ];

  final List<String> locations = [
    "Location 1",
    "Location 2",
    "Location 3",
    "Location 4",
    "Location 5",
    "Location 6",
    "Location 7",
    "Location 8",
    "Location 9",
    "Location 10",
  ];

  final List<String> sections = [
    "Section 1",
    "Section 2",
    "Section 3",
    "Section 4",
    "Section 5",
    "Section 6",
    "Section 7",
    "Section 8",
    "Section 9",
    "Section 10",
  ];

  List<Map<String, dynamic>> wikiDescription = [];

  List<String> getTitles() {
    // TODO: Implement logic to retrieve titles list from db
    return titles;
  }

  String getTitle({required int id}) {
    // TODO: Implement logic to retrieve title based on ID

    return titles[id];
  }

  List<Map<String, dynamic>> getDescription({required int id}) {
    // TODO: Combine with getWikiDescription to use flutter quill and get the description from db
    return [
      {
        "insert": "Description for $id / ${getTitle(id: id)}",
        "attributes": {"color": "#FF363942"}
      },
      {
        "insert": "\n",
      }
    ];
  }

  List<Map<String, dynamic>> getWikiDescription() {
    // TODO: Combine with getDescription to use flutter quill and get the description from db
    return wikiDescription;
  }

  List<String> getCharacters({required int id}) {
    // TODO: Implement logic to retrieve characters list from db
    return characters;
  }

  List<String> getLocations({required int id}) {
    // TODO: Implement logic to retrieve locations list from db
    return locations;
  }

  List<String> getSections({required int id}) {
    // TODO: Implement logic to retrieve sections list from db
    return sections;
  }

  List<String> getWikiDetailsPage(
      {required int wikiID,
      required int wikiSettingID,
      required int wikiDetailID}) {
    // TODO: Implement logic to retrieve wiki details page from db
    return ["Header 1", "Header 2", "Header 3"];
  }

  void addWiki(
      {required String title,
      required String sectionsName,
      required int numSections,
      required List<Map<String, dynamic>> description}) {
    // TODO: Implement logic to add a wiki to db
    wikiDescription = description;
  }
}
