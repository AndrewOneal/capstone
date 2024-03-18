/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("3js338lljsl3fvt");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "3js338lljsl3fvt",
    "created": "2024-02-06 09:10:14.253Z",
    "updated": "2024-02-06 09:10:14.253Z",
    "name": "People",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "lnksf5bv",
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
      },
      {
        "system": false,
        "id": "tczaxr1n",
        "name": "Age",
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
        "id": "y3xciquc",
        "name": "Status",
        "type": "bool",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {}
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
})
