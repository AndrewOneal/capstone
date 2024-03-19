/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pwg8bzqamhpitwz")

  collection.indexes = [
    "CREATE UNIQUE INDEX `idx_7Wdog3h` ON `location_details` (\n  `details_description`,\n  `location_id`,\n  `section_id`\n)"
  ]

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("pwg8bzqamhpitwz")

  collection.indexes = []

  return dao.saveCollection(collection)
})
