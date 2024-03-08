class DBHandler {
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
  List<String> getTitles() {
    // TODO: Implement logic to retrieve titles list from db
    return titles;
  }

  String getTitle({required int id}) {
    // TODO: Implement logic to retrieve title based on ID

    return titles[id];
  }

  String getDescription({required int id}) {
    // TODO: Implement logic to retrieve description based on ID
    return "Description for $id / ${getTitle(id: id)}";
  }

  void insertData(String data) {}

  void updateData(String data) {}

  void deleteData(String data) {}

  void saveSettings(String data) {}
}
