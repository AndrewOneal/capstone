import 'package:flutter_test/flutter_test.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:capstone/Utilities/db_util.dart';

final pb = PocketBase('http://127.0.0.1:8090');

void populateFakeData() async {
  await DBHandler().createWiki(wiki_name: "Fringe", wiki_section_count: 5, wiki_description: "Sci/Fi TV Series", section_name: "Season", wiki_admin_id: '');
  await DBHandler().createCharacter(character_name: "Olivia Dunham", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
  await DBHandler().createCharacter(character_name: "Dr. Robert", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
  await DBHandler().createLocation(location_name: "NYC HQ", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));

  // await Future.delayed(const Duration(seconds: 5));
  // await DBHandler().deleteWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
}
Future<void> main() async {
  setUpAll(() => {
    populateFakeData()
  });

  group("Testing WIKIs collection", () {
    test('READ Wikis', () async {
      var wikis = await DBHandler().getWikis();
      expect(wikis.length, greaterThan(0));
    });
    test('CREATE Wiki', () async {
      await DBHandler().createWiki(wiki_name: "Wheel of Time", wiki_section_count: 14, wiki_description: "Fantasy book series", section_name: "Book", wiki_admin_id: '');
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
      expect(name, contains("Olivia"));
    });
    test('CREATE Character', () async {
      var characters = await DBHandler().getCharacters(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(characters.length, greaterThan(0));
    });
  });
  //There is no reason for the sections in a series to be updated other than maybe the name
  group("Testing Sections collection", () {
    test('Creation, and Reading of Sections', () async {
      //Creation and reading of sections can be tested by simply doing a read statement of all fringe related sections. This is because sections are created automatically upon a wiki creation
      var sectionList = await DBHandler().getSections(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(sectionList.length, equals(5));
    });
    test('Delete Sections', () async {
      //Delete sections will also not be used by the application, this will be done automatically in the database when a specific wiki is delted
      await DBHandler().createWiki(wiki_name: "Wheel of Time", wiki_section_count: 14, wiki_description: "Fantasy book series", section_name: "Book", wiki_admin_id: '');
      var sectionList = await DBHandler().getSections(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Wheel of Time"));
      expect(sectionList.length, equals(14));
      await DBHandler().deleteWiki(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Wheel"));
    });
  });
  group("Testing Locations collection", () {
    test('READ locations', () async {
     var locations =  await DBHandler().getLocations(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
     expect(locations.length, greaterThan(0));
    });
    test('CREATE Location', () async {
      var locations =  await DBHandler().getLocations(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(locations[0]["name"], contains("NYC"));
    });
    test('UPDATE location', () async {
      await DBHandler().updateLocation(locationID: await DBHandler().getLocationIDFromName(locationName: "NYC"), new_location_name: "NYC HQ (Official)");
      var location = await DBHandler().getLocationIDFromName(locationName: "NYC HQ (Official)");
      expect(location.length, greaterThan(0));
    });
    test('Delete Location', () async {
      await DBHandler().createLocation(location_name: "London HQ", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      await DBHandler().deleteLocation(locationID: await DBHandler().getLocationIDFromName(locationName: "London"));
      var locations =  await DBHandler().getLocations(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Fringe"));
      expect(locations.length, greaterThan(0));
    });
  });

}
