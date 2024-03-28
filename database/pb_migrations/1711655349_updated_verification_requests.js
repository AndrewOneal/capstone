/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5b46kwf6d6w4lzk")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_i33fDmj` ON `verification_requests` (\n  `submitter_user_id`,\n  `wiki_id`,\n  `edited_package`\n)"
  ]

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ezwmdo0a",
    "name": "edited_package",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 2000000
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("5b46kwf6d6w4lzk")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_i33fDmj` ON `verification_requests` (\n  `submitter_user_id`,\n  `wiki_id`,\n  `edited_page`\n)"
  ]

  // update
  collection.schema.addField(new SchemaField({
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
  }))

  return dao.saveCollection(collection)
})
