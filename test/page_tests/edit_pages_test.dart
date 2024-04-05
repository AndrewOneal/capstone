import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone/Pages/CRUD/edit_character_details.dart';
import 'package:capstone/Pages/CRUD/edit_characters.dart';
import 'package:capstone/Pages/CRUD/edit_location_details.dart';
import 'package:capstone/Pages/CRUD/edit_locations.dart';
import 'package:capstone/Pages/CRUD/edit_section_details.dart';
import 'package:capstone/Pages/CRUD/edit_sections.dart';
import 'package:capstone/Pages/CRUD/edit_wiki.dart';
import 'package:capstone/Pages/CRUD/new_wiki.dart';
import 'sample_wiki.dart';

const Map<String, dynamic> sampleCharMap = {};
void main() {
  group('Edit Character Details Page', () {
    test('Edit Character Details Displays', () {
      const editCharacterDetailsPage =
          EditCharacterDetails(wikiMap: sampleWiki, maxSectionNo: 3);
      expect(editCharacterDetailsPage, isNotNull);
    });
  });

  group('Wiki Details Page', () {
    test('Wiki Character Details Page Displays', () {
      const wikiDetailsPage = WikiDetailsPage(
        wikiMap: sampleWiki,
        sectionNo: 1,
        detailName: "",
        detailType: "Character",
        detailMap: sampleWiki,
      );
      expect(wikiDetailsPage, isNotNull);
    });

    test('Wiki Location Details Page Displays', () {
      const wikiDetailsPage = WikiDetailsPage(
        wikiMap: sampleWiki,
        sectionNo: 1,
        detailName: "",
        detailType: "Location",
        detailMap: sampleWiki,
      );
      expect(wikiDetailsPage, isNotNull);
    });

    test('Wiki Section Details Page Displays', () {
      const wikiDetailsPage = WikiDetailsPage(
        wikiMap: sampleWiki,
        sectionNo: 1,
        detailName: "",
        detailType: "Section",
        detailMap: sampleWiki,
      );
      expect(wikiDetailsPage, isNotNull);
    });
  });

  group('Wiki Home Page', () {
    test('Wiki Home Page Displays', () {
      const wikiHomePage = WikiHomePage(wikiMap: sampleWiki);
      expect(wikiHomePage, isNotNull);
    });
  });

  group('Wiki Locations Page', () {
    test('Wiki Locations Page Displays', () {
      const wikiLocationsPage =
          WikiLocationsPage(wikiMap: sampleWiki, sectionNo: 1);
      expect(wikiLocationsPage, isNotNull);
    });
  });

  group('Wiki Sections Page', () {
    test('Wiki Sections Page Displays', () {
      const wikiSectionsPage =
          WikiSectionsPage(wikiMap: sampleWiki, sectionNo: 1);
      expect(wikiSectionsPage, isNotNull);
    });
  });
}
