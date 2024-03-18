/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "kyvovpixb1p9y49",
    "created": "2024-02-07 00:16:36.222Z",
    "updated": "2024-02-07 00:16:36.222Z",
    "name": "Descriptions",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "z7cmoxrz",
        "name": "Text",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "cepoihey",
        "name": "Part",
        "type": "number",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "noDecimal": false
        }
      },
      {
        "system": false,
        "id": "4wwbpcew",
        "name": "CharacterID",
        "type": "text",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [],
    "listRule": "",
    "viewRule": "",
    "createRule": "",
    "updateRule": "",
    "deleteRule": "",
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("kyvovpixb1p9y49");

  return dao.deleteCollection(collection);
})
