/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "mzgyhth8dq6udt0",
    "created": "2024-03-18 23:46:11.311Z",
    "updated": "2024-03-18 23:46:11.311Z",
    "name": "locations",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "4rcycqlo",
        "name": "name",
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
        "id": "b6jnipjq",
        "name": "wiki_id",
        "type": "relation",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "8vq2pworsav0yv9",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": null,
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
  const collection = dao.findCollectionByNameOrId("mzgyhth8dq6udt0");

  return dao.deleteCollection(collection);
})
