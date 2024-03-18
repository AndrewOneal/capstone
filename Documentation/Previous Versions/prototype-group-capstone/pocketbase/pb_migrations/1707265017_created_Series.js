/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "yb9xpy473mrpveh",
    "created": "2024-02-07 00:16:57.185Z",
    "updated": "2024-02-07 00:16:57.185Z",
    "name": "Series",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "fp8l1m11",
        "name": "NoOfParts",
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
        "id": "tk5g7drq",
        "name": "Name",
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
  const collection = dao.findCollectionByNameOrId("yb9xpy473mrpveh");

  return dao.deleteCollection(collection);
})
