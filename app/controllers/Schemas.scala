package controllers

import play.api.Logger
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import play.api.libs.json._
import play.api.mvc._
import play.modules.reactivemongo.MongoController
import play.modules.reactivemongo.json.collection.JSONCollection

trait Schemas extends MongoController {
  this: Controller =>

  /**
   * Get a JSONCollection (a Collection implementation that is designed to work with JsObject, Reads and Writes.)
   * Note that the `collection` is not a `val`, but a `def`.
   * By not storing the collection reference potential problems are avoided in development with Play hot-reloading.
   */
  def schemasCollection: JSONCollection = db.collection[JSONCollection]("schemas")

  def schema(id: String) = Action.async {
    Logger.info(s"Client requested schema: $id")

    schemasCollection.find(Json.obj("id" -> id)).one[JsValue].collect {
      case Some(schema) => Ok(schema)
    }
  }
}

object Schemas extends Controller with Schemas