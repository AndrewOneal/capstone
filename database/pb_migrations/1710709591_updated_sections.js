/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "zfnka226",
    "name": "wiki_id",
    "type": "relation",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "8vq2pworsav0yv9",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "zfnka226",
    "name": "wiki_name",
    "type": "relation",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "8vq2pworsav0yv9",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
})
