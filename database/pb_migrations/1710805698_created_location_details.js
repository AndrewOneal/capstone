/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "pwg8bzqamhpitwz",
    "created": "2024-03-18 23:48:18.568Z",
    "updated": "2024-03-18 23:48:18.568Z",
    "name": "location_details",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "eyibba27",
        "name": "details_description",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 2000000
        }
      },
      {
        "system": false,
        "id": "xnz7e50e",
        "name": "location_id",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "mzgyhth8dq6udt0",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "ssemkxbx",
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
      }
    ],
    "indexes": [],
    "listRule": "",
    "viewRule": "",
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {}
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("pwg8bzqamhpitwz");

  return dao.deleteCollection(collection);
})
