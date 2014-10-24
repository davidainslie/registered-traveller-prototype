import java.net.URL
import scala.collection.JavaConversions
import scala.io.Source
import scala.util.{Failure, Success, Try}
import play.api.Logger
import play.api.libs.json.{JsObject, Json, JsValue}
import com.github.fge.jackson.JsonLoader
import com.github.fge.jsonschema.core.exceptions.ProcessingException
import com.github.fge.jsonschema.main.{JsonSchema, JsonSchemaFactory}

package object json {
  implicit val urlContentToString = (url: URL) => Source.fromURL(url).getLines().mkString

  implicit val urlContentToJson = (url: URL) => Json.parse(url)

  implicit val jsonToString = (j: JsValue) => Json.stringify(j)

  val json: URL => JsObject = Json.parse(_).as[JsObject]

  val fromClasspath: String => URL = classpath => getClass.getResource(classpath)

  /**
   * Given a JSON schema, validate given JSON against said schema.
   * SchemaException thrown for a given invalid schema.
   * (This function will handle a schema extracted from Mongo).
   */
  val validate: JsValue => JsValue => Try[JsValue] = schema => {
    val jsonSchema = {
      val jsonSchemaString = Json.stringify(schema.as[JsObject] - "_id")

      val jsonSchemaNode = JsonLoader.fromString {
        if (jsonSchemaString.contains("$schema")) jsonSchemaString
        else jsonSchemaString.replaceAll("schema", """\$schema""")
      }

      val syntaxValidator = JsonSchemaFactory.byDefault().getSyntaxValidator
      val processingReport = syntaxValidator.validateSchema(jsonSchemaNode)

      if (processingReport.isSuccess) {
        Logger.info(s"Successfully parsed given JSON schema: $processingReport")
        JsonSchemaFactory.byDefault().getJsonSchema(jsonSchemaNode)
      } else {
        import JavaConversions._

        Logger.error(s"Given JSON schema is invalid: $processingReport")
        throw SchemaException(processingReport.iterator().toList map { processingMessage => processingMessage.getMessage})
      }
    }

    validate(jsonSchema)
  }

  /**
   * Given a JSON schema, validate given JSON against said schema.
   */
  def validate(jsonSchema: JsonSchema): JsValue => Try[JsValue] = json => {
    try {
      val processingReport = jsonSchema.validate(JsonLoader.fromString(Json.stringify(json)))

      if (processingReport.isSuccess) {
        Success(json)
      } else {
        import JavaConversions._

        Logger.error(s"Given JSON is invalid: $processingReport")
        Failure(ValidationException(processingReport.iterator().toList map { processingMessage => processingMessage.getMessage}))
      }
    } catch {
      case e: ProcessingException =>
        Logger.error(e.getProcessingMessage.getMessage)
        Failure(ValidationException(List(e.getProcessingMessage.getMessage)))
      case t: Throwable =>
        Logger.error(t.getMessage)
        Failure(ValidationException(List(t.getMessage)))
    }
  }
}