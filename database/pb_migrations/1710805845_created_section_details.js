/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "r65hinqpiej327e",
    "created": "2024-03-18 23:50:45.449Z",
    "updated": "2024-03-18 23:50:45.449Z",
    "name": "section_details",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "jczm9jg9",
        "name": "section_id",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "ri7jvxv7kzvh04t",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "fjoratac",
        "name": "details_description",
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
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("r65hinqpiej327e");

  return dao.deleteCollection(collection);
})
