/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "jr8b5i7z8koan9r",
    "created": "2024-02-07 00:14:47.018Z",
    "updated": "2024-02-07 00:14:47.018Z",
    "name": "Characters",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "zfys4rms",
        "name": "Name",
        "type": "text",
        "required": true,
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
        "id": "r58qwzrx",
        "name": "Image",
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
  const collection = dao.findCollectionByNameOrId("jr8b5i7z8koan9r");

  return dao.deleteCollection(collection);
})
