/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t")

  // remove
  collection.schema.removeField("rkfyb2h1")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("ri7jvxv7kzvh04t")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "rkfyb2h1",
    "name": "section_no_thing",
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
