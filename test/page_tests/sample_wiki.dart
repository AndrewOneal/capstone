const Map<String, dynamic> sampleWiki = {
  'id': 'mgdzj2sn74biu9w',
  'wiki_description': 'The best show of all time',
  'wiki_name': 'Fringe',
};

const List<Map<String, dynamic>> sampleWikis = [
  {
    'id': 'mgdzj2sn74biu9w',
    'wiki_description': 'The best show of all time',
    'wiki_name': 'Fringe',
  },
  {
    'id': 'mgdzj2sn74biu9i',
    'wiki_description': 'The best show of all time',
    'wiki_name': 'Fringe2',
  },
];

const String sampleSectionName = "Season 1";

const List<Map<String, dynamic>> sampleSections = [
  {
    "id": "nida26ase8j2d1r",
    "collectionName": "sections",
    "section_name": "Season 5",
    "section_no": 5,
    "wiki_id": "mgdzj2sn74biu9w"
  },
  {
    "id": "ppd4ry5cotlqsx8",
    "collectionName": "sections",
    "section_name": "Season 4",
    "section_no": 4,
    "wiki_id": "mgdzj2sn74biu9w"
  },
  {
    "id": "yitfx6ykb5567t3",
    "collectionName": "sections",
    "section_name": "Season 3",
    "section_no": 3,
    "wiki_id": "mgdzj2sn74biu9w"
  },
  {
    "id": "fot0tt33oqy0mn9",
    "collectionName": "sections",
    "section_name": "Season 2",
    "section_no": 2,
    "wiki_id": "mgdzj2sn74biu9w"
  },
  {
    "id": "yhipcx37al7pvjc",
    "collectionName": "sections",
    "section_name": "Season 1",
    "section_no": 1,
    "wiki_id": "mgdzj2sn74biu9w"
  }
];

const String sampleCharacterName = "Olivia Dunham";

const List<Map<String, dynamic>> sampleCharacters = [
  {
    "id": "4zwlba5hnj840za",
    "name": "Olivia Dunham",
    "wiki_id": "mgdzj2sn74biu9w"
  },
  {
    "id": "ulwqmm7cb46ab7o",
    "name": "Olivia Dunham The 3rd",
    "wiki_id": "mgdzj2sn74biu9w"
  }
];

const String sampleLocationName = "NYC HQ";

const List<Map<String, dynamic>> sampleLocations = [
  {"id": "2wfh61krquejq8t", "name": "NYC HQ", "wiki_id": "mgdzj2sn74biu9w"},
  {
    "id": "fb0hesgiqziadte",
    "name": "NYC HQ (Official)",
    "wiki_id": "mgdzj2sn74biu9w"
  }
];

const List<Map<String, dynamic>> sampleSection = [
  {
    "id": "nj9cd58w37lubwa",
    "details_description": {
      "String":
          "Book 1 is the first official season of Avatar the Last Airbender. It covers the first third of the story."
    },
    "section_name": "Season 1",
    "section_no": 1,
  }
];

const List<Map<String, dynamic>> sampleCharacter = [
  {
    "id": "tjamf8homoiwwpw",
    "details_description":
        "{String: Olivia discovers his people are dead in book 1 and onwawrd}",
    "character_id": "4zwlba5hnj840za",
    "section_name": "Season 1",
    "section_no": 1,
    "section_id": "yhipcx37al7pvjc"
  },
  {
    "id": "h1n0t8nf0ilhtyc",
    "details_description":
        "{String: Olivia learns energy bending to defeat firelord Ozai in book 3}",
    "character_id": "4zwlba5hnj840za",
    "section_name": "Season 3",
    "section_no": 3,
    "section_id": "yitfx6ykb5567t3"
  }
];

const List<Map<String, dynamic>> sampleLocation = [
  {
    "id": "ctd9utnzl1wazs0",
    "details_description":
        "{String: By book 3, NYC HQ is officially part of the war since the fire nation took them down and injured Aang.}",
    "location_id": "2wfh61krquejq8t",
    "section_name": "Season 3",
    "section_no": 3,
    "section_id": "yitfx6ykb5567t3"
  },
  {
    "id": "4r8aakqu0uld7e4",
    "details_description":
        "{String: NYC HQ is the earth kingdom capital, not involved in the 100 year war by book 2}",
    "location_id": "2wfh61krquejq8t",
    "section_name": "Season 2",
    "section_no": 2,
    "section_id": "fot0tt33oqy0mn9"
  }
];
