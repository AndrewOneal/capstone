import 'package:flutter_test/flutter_test.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:capstone/Utilities/db_util.dart';

final pb = PocketBase('http://127.0.0.1:8090');

void populateFakeData() async {
  await DBHandler().createWiki(wiki_name: "Fringe", wiki_section_count: 5, wiki_description: "Sci/Fi TV Series", section_name: "Season");
  await DBHandler().createCharacter(character_name: "Olivia Dunham", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
  await DBHandler().createCharacter(character_name: "Dr. Robert", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
  await DBHandler().createLocation(location_name: "NYC HQ", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
}
void deleteFakeData() async {
  await DBHandler().deleteWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
}

void main() {
  populateFakeData();

  group("Testing WIKIs collection", () {
    test('READ Wikis', () async {
      var wikis = await DBHandler().getWikis();
      expect(wikis.length, greaterThan(0));
    });
    test('CREATE Wiki', () async {
      await DBHandler().createWiki(wiki_name: "Wheel of Time", wiki_section_count: 14, wiki_description: "Fantasy book series", section_name: "Book");
      var wiki = await DBHandler().getWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Wheel of Time"));
      expect(wiki["wiki_name"], "Wheel of Time");
    });
    test('UPDATE Wiki', () async {
      await DBHandler().updateWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"), new_name: "Fringe", new_description: "The best show of all time");
      var wiki = await DBHandler().getWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(wiki["wiki_description"], "The best show of all time");
    });
    test('DELETE Wiki', () async {
      //Needs slight adjustment
      await DBHandler().deleteWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Wheel of Time"));
    });
    test('', () async {

    });
  });
  group("Testing Characters collection", () {
    test('READ Characters', () async {
      var characters = await DBHandler().getCharacters(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(characters.length, greaterThan(0));
    });
    test('DELETE Character', () async {
      await DBHandler().deleteCharacter(characterID: await DBHandler().getCharacterIDFromName(characterName: "Dr.", wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe")));
      var characters = await DBHandler().getCharacters(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(characters.length, greaterThan(0));
    });
    test('UPDATE Character', () async {
      await DBHandler().updateCharacter(characterID: await DBHandler().getCharacterIDFromName(characterName: "Olivia", wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe")), new_name: "Olivia Dunham The 3rd", new_nickname: "Good person");
      var name = await DBHandler().getCharacterName(characterID: await DBHandler().getCharacterIDFromName(characterName: "Olivia", wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe")));
      expect(name, equals("Olivia Dunham The 3rd"));
    });
    test('CREATE Character', () async {
      var characters = await DBHandler().getCharacters(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(characters.length, greaterThan(0));
    });
  });
  group("Testing Sections collection", () {
    test('', () async {

    });
  });
  group("Testing Locations collection", () {
    test('', () async {

    });
  });
}
