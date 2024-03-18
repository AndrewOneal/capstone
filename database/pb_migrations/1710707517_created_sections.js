/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "ri7jvxv7kzvh04t",
    "created": "2024-03-17 20:31:57.703Z",
    "updated": "2024-03-17 20:31:57.703Z",
    "name": "sections",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "d3n20rpf",
        "name": "section_name",
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
        "id": "rkfyb2h1",
        "name": "section_no",
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
        "id": "zfnka226",
        "name": "wiki_id",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "8vq2pworsav0yv9",
          "cascadeDelete": true,
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
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t");

  return dao.deleteCollection(collection);
})
