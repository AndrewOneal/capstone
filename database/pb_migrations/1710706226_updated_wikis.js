/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  // remove
  collection.schema.removeField("osiuu6qp")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "osiuu6qp",
    "name": "wiki_id",
    "type": "text",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
})
