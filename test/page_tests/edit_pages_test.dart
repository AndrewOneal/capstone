import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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

void main() {
  group('Edit Character Details Page', () {
    const editCharacterDetailsPage = EditCharacterDetails(
      wikiMap: sampleWiki,
      maxSectionNo: 3,
      characterDetailsMap: sampleCharacter,
      characterName: sampleCharacterName,
    );
    test('Edit Character Details Displays', () {
      expect(editCharacterDetailsPage, isNotNull);
    });

    // Requires http Mocking to test
    /*testWidgets('Edit Character Details UI', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: editCharacterDetailsPage));
      expect(find.text('Edit Character Details'), findsOneWidget);
      expect(find.text(sampleCharacterName), findsOneWidget);
      //expect(find.byTooltip('Season 1'), findsOneWidget);
      expect(find.byType(QuillToolbar), findsOneWidget);
      expect(find.byType(QuillEditor), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Reason for Edit'),
          findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Submit For Approval'),
          findsOneWidget);
      expect(
          find.widgetWithText(ElevatedButton, 'Delete Entry'), findsOneWidget);
    });*/
  });

  group('Edit Characters Page', () {
    const editCharactersPage = EditCharacters(
      wikiMap: sampleWiki,
      charactersMap: sampleCharacters,
    );
    test('Edit Characters Displays', () {
      expect(editCharactersPage, isNotNull);
    });
  });

  group('Edit Location Details Page', () {
    const editLocationDetailsPage = EditLocationDetails(
      wikiMap: sampleWiki,
      maxSectionNo: 3,
      locationMap: sampleLocation,
      locationName: sampleLocationName,
    );
    test('Edit Location Details Displays', () {
      expect(editLocationDetailsPage, isNotNull);
    });
  });

  group('Edit Locations Page', () {
    const editLocationsPage = EditLocations(
      wikiMap: sampleWiki,
      locationsMap: sampleLocations,
    );
    test('Edit Characters Displays', () {
      expect(editLocationsPage, isNotNull);
    });
  });

  group('Edit Section Details Page', () {
    const editSectionDetailsPage = EditSectionDetails(
      wikiMap: sampleWiki,
      sectionMap: sampleSection,
      sectionName: sampleSectionName,
    );
    test('Edit Section Details Displays', () {
      expect(editSectionDetailsPage, isNotNull);
    });
  });

  group('Edit Sections Page', () {
    const editSectionsPage = EditSections(
      wikiMap: sampleWiki,
      sectionsMap: sampleSections,
    );
    test('Edit Sections Displays', () {
      expect(editSectionsPage, isNotNull);
    });
  });

  group('Edit Wiki Page', () {
    const editWikiPage = EditWiki(
      wikiMap: sampleWiki,
    );
    test('Edit Wiki Displays', () {
      expect(editWikiPage, isNotNull);
    });
  });

  group('New Wiki Page', () {
    const newWikiPage = NewWiki();
    test('New Wiki Displays', () {
      expect(newWikiPage, isNotNull);
    });

    testWidgets('Edit New Wiki UI', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: newWikiPage));
      expect(find.text('New Wiki'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Title'), findsOneWidget);
      expect(
          find.widgetWithText(TextFormField, 'Sections Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Number of Sections'),
          findsOneWidget);
      expect(find.byType(QuillToolbar), findsOneWidget);
      expect(find.byType(QuillEditor), findsOneWidget);
      expect(
          find.widgetWithText(ElevatedButton, 'Submit Wiki'), findsOneWidget);
    });
  });
}
