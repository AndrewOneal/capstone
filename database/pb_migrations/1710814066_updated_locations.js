/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mzgyhth8dq6udt0")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_P6YOrD3` ON `locations` (\n  `name`,\n  `wiki_id`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mzgyhth8dq6udt0")

  collection.indexes = []

  return dao.saveCollection(collection)
})
