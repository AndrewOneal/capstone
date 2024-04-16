/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  // remove
  collection.schema.removeField("feiysls2")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "tf25uolz",
    "name": "wiki_description",
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
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "feiysls2",
    "name": "wiki_description",
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
  collection.schema.removeField("tf25uolz")

  return dao.saveCollection(collection)
})
