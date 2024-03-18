/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x")

  collection.listRule = ""
  collection.viewRule = ""

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("82jqpl9d5kvuj8x")

  collection.listRule = null
  collection.viewRule = null

  return dao.saveCollection(collection)
})
