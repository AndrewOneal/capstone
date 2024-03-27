/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5b46kwf6d6w4lzk")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_i33fDmj` ON `verification_requests` (\n  `submitter_username`,\n  `wiki_name`,\n  `edited_page`\n)"
  ]

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "az3qqi23",
    "name": "submitter_username",
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
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5b46kwf6d6w4lzk")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_i33fDmj` ON `verification_requests` (\n  `submitter_name`,\n  `wiki_name`,\n  `edited_page`\n)"
  ]

  // update
  collection.schema.addField(new SchemaField({
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
  }))

  return dao.saveCollection(collection)
})
