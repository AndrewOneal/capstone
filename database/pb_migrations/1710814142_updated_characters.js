/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0yfhrgqnt0nkzu7")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_Tm71SwA` ON `characters` (\n  `name`,\n  `wiki_id`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0yfhrgqnt0nkzu7")

  collection.indexes = []

  return dao.saveCollection(collection)
})
