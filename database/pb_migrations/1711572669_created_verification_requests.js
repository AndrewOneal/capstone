/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "5b46kwf6d6w4lzk",
    "created": "2024-03-27 20:51:09.607Z",
    "updated": "2024-03-27 20:51:09.607Z",
    "name": "verification_requests",
    "type": "base",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "az3qqi23",
        "name": "submitter_name",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "_pb_users_auth_",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "j7xw8dkh",
        "name": "wiki_name",
        "type": "relation",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "collectionId": "8vq2pworsav0yv9",
          "cascadeDelete": false,
          "minSelect": null,
          "maxSelect": 1,
          "displayFields": null
        }
      },
      {
        "system": false,
        "id": "ezwmdo0a",
        "name": "edited_page",
        "type": "json",
        "required": false,
        "presentable": false,
        "unique": false,
        "options": {
          "maxSize": 2000000
        }
      }
    ],
    "indexes": [
      "CREATE UNIQUE INDEX `idx_i33fDmj` ON `verification_requests` (\n  `submitter_name`,\n  `wiki_name`,\n  `edited_page`\n)"
    ],
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
  const collection = dao.findCollectionByNameOrId("5b46kwf6d6w4lzk");

  return dao.deleteCollection(collection);
})
