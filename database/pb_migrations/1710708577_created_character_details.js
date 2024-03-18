/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "82jqpl9d5kvuj8x",
    "created": "2024-03-17 20:49:37.202Z",
    "updated": "2024-03-17 20:49:37.202Z",
    "name": "character_details",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "kt7dvgej",
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
        "id": "n3amijvc",
        "name": "character_id",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "0yfhrgqnt0nkzu7",
          "cascadeDelete": true,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "8b66xaot",
        "name": "section_id",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "ri7jvxv7kzvh04t",
          "cascadeDelete": true,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
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
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x");

  return dao.deleteCollection(collection);
})
