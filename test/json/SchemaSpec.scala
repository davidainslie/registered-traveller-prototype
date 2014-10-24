package json

import scala.util.Try
import play.api.libs.json.{JsValue, Json}
import org.specs2.mutable.Specification

class SchemaSpec extends Specification {
  "JSON schema" should {
    "be valid" in {
      val jsonSchema = Json.parse("""{
        "$schema": "http://json-schema.org/draft-04/schema",
        "type": "object",
        "properties": {
          "name": {
            "type": "string"
          }
        }
      }""")

      validate(jsonSchema) must beAnInstanceOf[JsValue => Try[JsValue]]
    }

    "be invalid" in {
      val jsonSchema = Json.parse("""{
        "$schema": "http://json-schema.org/draft-04/schema",
        "type": "object",
        "properties": {
          "name": {
            "type": "INVALID TYPE"
          }
        }
      }""")

      validate(jsonSchema) must throwA[SchemaException]
    }
  }
}