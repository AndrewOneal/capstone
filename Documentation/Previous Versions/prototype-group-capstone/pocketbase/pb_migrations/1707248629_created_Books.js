/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "ys3prxn7i0cmdx9",
    "created": "2024-02-06 19:43:49.184Z",
    "updated": "2024-02-06 19:43:49.184Z",
    "name": "Books",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "zsorsbl8",
        "name": "notes",
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
        "id": "6tckaxve",
        "name": "order",
        "type": "number",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "noDecimal": false
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
  const collection = dao.findCollectionByNameOrId("ys3prxn7i0cmdx9");

  return dao.deleteCollection(collection);
})
