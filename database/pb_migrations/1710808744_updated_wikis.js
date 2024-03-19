/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_dgqCHw6` ON `wikis` (`wiki_name`)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  collection.indexes = []

  return dao.saveCollection(collection)
})
