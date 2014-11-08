package controllers

import java.util.UUID
import scala.concurrent.Future
import scala.util.Try
import play.api.libs.concurrent.Execution.Implicits.defaultContext // TODO execution context per "module" e.g. one for "controllers"
import play.api.libs.json._
import play.api.mvc.{Action, Controller}
import play.modules.reactivemongo.MongoController
import play.modules.reactivemongo.json.BSONFormats.BSONObjectIDFormat
import play.modules.reactivemongo.json.collection.JSONCollection
import reactivemongo.bson.BSONObjectID
import json._

trait Customers extends MongoController {
  this: Controller =>

  /** TODO To cache and avoid contant datastore interaction, just make the following a "val" */
  def customerSchema: Future[Option[JsValue]] = schemasCollection.find(Json.obj("id" -> "customer")).one[JsValue]

  val validateCustomer: Future[JsValue => Try[JsValue]] = {
    customerSchema.collect {
      case Some(schema) => validate(schema)
    }
  }

  val validateRegister: Future[JsValue => Try[JsValue]] = {
    schemasCollection.find(Json.obj("id" -> "register")).one[JsValue].collect {
      case Some(schema) => validate(schema)
    }
  }

  /**
   * Get a JSONCollection (a Collection implementation that is designed to work with JsObject, Reads and Writes.)
   * Note that the `collection` is not a `val`, but a `def`.
   * By not storing the collection reference potential problems are avoided in development with Play hot-reloading.
   */
  def customersCollection: JSONCollection = db.collection[JSONCollection]("customers")

  def schemasCollection: JSONCollection = db.collection[JSONCollection]("schemas")

  def invitationCodeCollection: JSONCollection = db.collection[JSONCollection]("invitationCodes")

  def invitationCode(code: String) = Action.async { request =>
    (for {
      invitationCode <- invitationCodeCollection.find(Json.obj("_id" -> code)).one[JsValue]
    } yield
      invitationCode.fold { NotFound(Json.obj("error" -> "Invitation code was not found")) }
                          { code => Ok(Json.obj("invitationCode" -> code)) }
    ) recover {
      case t: Throwable => BadRequest(Json.obj("response" -> s"Failed to acquire invitation code because of ${t.getMessage}"))
    }
  }

  /**
   * request.body is a JsValue.
   * There is an implicit Writes that turns this JsValue as a JsObject, so you can call insert() with this JsValue.
   * insert() takes a JsObject as parameter, or anything that can be turned into a JsObject using a Writes.
   */
  def register = Action.async(parse.json) { request =>
    validateRegister.flatMap {
      _(request.body).map { registration =>
        val id = UUID.randomUUID()

        customersCollection.save(Json.obj("id" -> id) ++ registration.as[JsObject]).map { _ =>
          Created(Json.obj("response" -> s"""Successfully registered with generated ID: $id""", "id" -> id))
        }
      } getOrElse Future.successful(BadRequest(Json.obj("response" -> "Failed to save invalid registration")))
    }
  }

  def get(id: String) = Action.async { request =>
    (for {
      Some(schema) <- customerSchema // Keep this first as it is already a future so this "for" can be as efficient as possible
      customer <- customersCollection.find(Json.obj("id" -> id)).one[JsValue]
    } yield {
      customer.fold { Ok(Json.obj("schema" -> schema)) }
      { c => Ok(Json.obj("data" -> c, "schema" -> schema)) }
    }) recover {
      case t: Throwable => BadRequest(Json.obj("response" -> s"Failed to acquire your details because of ${t.getMessage}"))
    }
  }

  def update = Action.async(parse.json) { request =>
    validateCustomer.flatMap {
      _(request.body).map { customer =>
        val id = (customer \ "id").as[String]

        customersCollection.save(customer).map { _ =>
          Ok(Json.obj("response" -> s"""Successful update"""))
        }
      } getOrElse Future.successful(BadRequest(Json.obj("_id" -> BSONObjectID.generate, "response" -> "Failed to update your details")))
    }
  }
}

object Customers extends Controller with Customers