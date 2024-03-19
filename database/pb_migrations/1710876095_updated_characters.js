/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0yfhrgqnt0nkzu7")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "jkrbq2do",
    "name": "wiki_id",
    "type": "relation",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "8vq2pworsav0yv9",
      "cascadeDelete": true,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("0yfhrgqnt0nkzu7")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "jkrbq2do",
    "name": "wiki_id",
    "type": "relation",
    "required": true,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "8vq2pworsav0yv9",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
})
