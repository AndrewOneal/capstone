import 'package:capstone/Pages/Wiki/wiki_characters.dart';
import 'package:capstone/Pages/Wiki/wiki_home.dart';
import 'package:capstone/Pages/Wiki/wiki_details.dart';
import 'package:capstone/Pages/Wiki/wiki_locations.dart';
import 'package:capstone/Pages/Wiki/wiki_sections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

const Map<String, dynamic> sampleWikiMap = {
  'id': 'mgdzj2sn74biu9w',
  'created': '2024-03-31 22:25:40.585Z',
  'updated': '2024-03-31 22:27:35.885Z',
  'collectionId': '8vq2pworsav0yv9',
  'collectionName': 'wikis',
  'expand': {},
  'wiki_admin': '',
  'wiki_description': 'The best show of all time',
  'wiki_name': 'Fringe',
  'wiki_section_count': 5
};

void main() {
  group('Wiki Characters Page', () {
    test('Wiki Characters Page Displays', () {
      const wikiCharactersPage =
          WikiCharactersPage(wikiMap: sampleWikiMap, sectionNo: 1);
      expect(wikiCharactersPage, isNotNull);
    });
  });

  group('Wiki Details Page', () {
    test('Wiki Character Details Page Displays', () {
      const wikiDetailsPage = WikiDetailsPage(
        wikiMap: sampleWikiMap,
        sectionNo: 1,
        detailName: "",
        detailType: "Character",
        detailMap: sampleWikiMap,
      );
      expect(wikiDetailsPage, isNotNull);
    });

    test('Wiki Location Details Page Displays', () {
      const wikiDetailsPage = WikiDetailsPage(
        wikiMap: sampleWikiMap,
        sectionNo: 1,
        detailName: "",
        detailType: "Location",
        detailMap: sampleWikiMap,
      );
      expect(wikiDetailsPage, isNotNull);
    });

    test('Wiki Section Details Page Displays', () {
      const wikiDetailsPage = WikiDetailsPage(
        wikiMap: sampleWikiMap,
        sectionNo: 1,
        detailName: "",
        detailType: "Section",
        detailMap: sampleWikiMap,
      );
      expect(wikiDetailsPage, isNotNull);
    });
  });

  group('Wiki Home Page', () {
    test('Wiki Home Page Displays', () {
      const wikiHomePage = WikiHomePage(wikiMap: sampleWikiMap);
      expect(wikiHomePage, isNotNull);
    });
  });

  group('Wiki Locations Page', () {
    test('Wiki Locations Page Displays', () {
      const wikiLocationsPage =
          WikiLocationsPage(wikiMap: sampleWikiMap, sectionNo: 1);
      expect(wikiLocationsPage, isNotNull);
    });
  });

  group('Wiki Sections Page', () {
    test('Wiki Sections Page Displays', () {
      const wikiSectionsPage =
          WikiSectionsPage(wikiMap: sampleWikiMap, sectionNo: 1);
      expect(wikiSectionsPage, isNotNull);
    });
  });
}
