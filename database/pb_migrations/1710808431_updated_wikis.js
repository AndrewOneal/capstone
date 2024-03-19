/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  // remove
  collection.schema.removeField("izrcswph")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "jry7qb36",
    "name": "wiki_admin",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "_pb_users_auth_",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("8vq2pworsav0yv9")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "izrcswph",
    "name": "wiki_admin",
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
  collection.schema.removeField("jry7qb36")

  return dao.saveCollection(collection)
})
