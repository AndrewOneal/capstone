/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x")

  collection.name = "character_details"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x")

  collection.name = "characterDetails"

  return dao.saveCollection(collection)
})
