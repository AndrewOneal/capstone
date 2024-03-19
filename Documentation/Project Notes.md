Pocketbase credentials:
Username: yes@gmail.com
Password: yes@gmail.com

Questions/Potential things to note:
- Do async DB functions work well with FutureBuilder
- Querying characters and locations across 2 different wikis
- How to handle verification request system in relation to the database

DB things to clean up/Do:
- Backup DB schema
- Create list of commands to immediately populate pocketbase with effective dummy data
- Create tests for each DB function
- CRUD for settings & users
- Adding error handling to READ operations
- Fixing comments

PLAN for settings/Authentication:
- 

PLAN for Deleting/Updating information:
- When a parent record is deleted, it's children should also be deleted with cascade deletes. (Ex: Deleting a wiki should delete every other record in the database associated to that wiki)
- Deleting Wiki = Delete all locations/details, all characters/details, and all sections/details
- Deleting Character = Remove all related character details
- Deleting Location = Remove all related location details
- Deleting Section = MUST cascade delete ALL characters/location details related to that section
- Deleting Section detail = Remove a specific section detail using ID
- Updating wiki = wiki name, section count, and description can be changed
- Updating Sections = can ONLY change section name, nothing else
- Updating Section details = can ONLY change details description
- Updating Characters = can ONLY change name, and nickname
- Updating Character details = can ONLY change details description
- Updating Locations = can ONLY change location name
- Updating Location Details = can ONLY change details description

Quill Editor Notes:
- Data is stored as a Delta and encoded in JSON format
- Data is pulled as a JSON from the database and assigned to the quill document

Working with JSON in flutter
1st method: Using a class to control type safety and logic. 4 functions & 3 datatypes:
    - toJson(), uses class instance to output a map. #Custom class method
    - fromJson(), converts map to class instance via a constructor. #Custom class method
    - jsonDecode(), converts raw JSON string to map<String, dynamic>
    - jsonEncode(), takes class instance and outputs back to raw JSON string
    - Idea behind this method is to convert raw JSON string into a class object first to detect compilation issues and data integrity. The logic would be built into the class. Then that class instance would be usable/editable. THEN the jsonEncode function would convert the class instance back into a raw JSON string that can be stored in the database
2nd method: Just using JSON strings and manually setting up code blocks for the logic. 2 functions and 2 datatypes:
    - jsonDecode, converts raw JSON string into map<String, Dynamic>
    - jsonEncode, converts map<String, Dynamic> into raw JSON string
    - This method is much simpler but also more error-prone. 


Tables:
[WIKIS]
- Wiki ID --> String
- Wiki Name --> String
- Wiki Admin --> String
- section_count --> int

[SECTIONS]
- Section ID --> String
- Section Name --> String
- Section # --> Int
- *Wiki ID --> String

[SECTION_DETAILS]
- section_details_id --> String
- *section_id --> String
- details_description

[CHARACTERS]
- Character ID --> String
- Character name --> String
- nickname
- *Wiki ID --> String

[CHARACTER DETAILS]
- Character Detail ID --> String
- Character Description/Detail --> String #JSON in delta/string format from Quill (*Labeled as JSON in pocketbase DB)
- *Character ID --> String
- *Section # --> Int

[LOCATIONS]
- Location ID --> String
- Location Name --> String
- Wiki ID --> String

[LOCATION_DETAILS]
- Location_details ID --> String
- location_details_summary --> String
- *Location ID --> String
- *Section ID --> String

[SETTINGS]
- user_id --> String
- wiki_id --> String
- latest_point --> Int

[USERS]
- User ID --> String
- User Name --> String
- Administrator --> Bool

Pages:
Home Page 
    - Named Wiki #(Dialog popup, "Which book are you on?"). Editable on each subsequent wiki page
        - Characters 
        - Seasons/Summaries
        - Timeline
    - Named/Owned Wiki
        - Edit/Verification Requests Page
        - 
Settings
Profile

WIKI Creation commands:
Creates star wars wiki:
await DBHandler().createWiki(wiki_name: "Star Wars", wiki_section_count: 9, wiki_description: "Covers the star wars movies 1-9", section_name: 'Movie');
await DBHandler().createCharacter(character_name: "Anakin", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Star Wars"));
await DBHandler().createCharacterDetail(details_description: '{"String":"New detail about Anakin from movie 2"}', associated_character_id: await DBHandler().getCharacterIDFromName(characterName: "Anakin", wikiID: await DBHandler().getWikiIDFromName(wikiName: "Star Wars")), associated_section_id: await DBHandler().getSectionID(wikiID: await DBHandler().getWikiIDFromName(wikiName: "Star Wars"), sectionNo: 2));
await DBHandler().createLocation(location_name: "Coruscant", associated_wiki_id: await DBHandler().getWikiIDFromName(wikiName: "Star Wars"));

