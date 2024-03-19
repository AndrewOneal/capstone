/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r65hinqpiej327e")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_zedlytu` ON `section_details` (\n  `section_id`,\n  `details_description`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r65hinqpiej327e")

  collection.indexes = []

  return dao.saveCollection(collection)
})
