/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t")

  collection.indexes = [
    "CREATE INDEX `idx_JYviCdI` ON `sections` (\n  `section_no`,\n  `wiki_id`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t")

  collection.indexes = []

  return dao.saveCollection(collection)
})
