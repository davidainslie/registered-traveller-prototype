package json

import scala.util.Success
import play.api.libs.json.JsObject
import org.specs2.mutable.Specification

class RegisterSpec extends Specification {
  val registerJsonSchema = json(fromClasspath("/json/register-schema.json"))

  val registerJson = json(fromClasspath("/json/register.json"))

  "Register JSON" should {
    "be valid" in {
      validate(registerJsonSchema)(registerJson) must beLike {
        case Success(j: JsObject) => (j \ "eligible").as[String] mustEqual "yes"
      }
    }

    "have 'eligible' missing" in {
      val invalidRegisterJson = registerJson - "eligible"

      validate(registerJsonSchema)(invalidRegisterJson) must beAFailedTry
    }

    "have 'travel' details missing" in {
      val invalidRegisterJson = registerJson - "travel"

      validate(registerJsonSchema)(invalidRegisterJson) must beAFailedTry
    }
  }
}