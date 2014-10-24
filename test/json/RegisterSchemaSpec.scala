package json

import scala.util.Try
import play.api.libs.json.JsValue
import org.specs2.mutable.Specification

class RegisterSchemaSpec extends Specification {
  "Register JSON schema" should {
    "be valid" in {
      val schema = json(fromClasspath("/json/register-schema.json"))

      validate(schema) must beAnInstanceOf[JsValue => Try[JsValue]]
    }
  }
}