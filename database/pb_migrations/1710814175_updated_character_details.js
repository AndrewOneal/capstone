/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_eDY1bc0` ON `character_details` (\n  `details_description`,\n  `character_id`,\n  `section_id`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x")

  collection.indexes = []

  return dao.saveCollection(collection)
})
