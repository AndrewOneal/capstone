/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r65hinqpiej327e")

  // remove
  collection.schema.removeField("fjoratac")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "elimecbl",
    "name": "details_description",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 2000000
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("r65hinqpiej327e")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "fjoratac",
    "name": "details_description",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  // remove
  collection.schema.removeField("elimecbl")

  return dao.saveCollection(collection)
})
