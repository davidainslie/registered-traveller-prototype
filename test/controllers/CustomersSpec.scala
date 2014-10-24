package controllers

import play.api.http.MimeTypes
import play.api.mvc.Controller
import play.api.test._

// TODO Working on
/*
class CustomersSpec extends PlaySpecification {
  object Customers extends Controller with Customers

  "Customer" should {
    "acquire their details" in new WithApplication {
      val result = Customers.get("1")(FakeRequest())

      status(result) mustEqual OK
      contentType(result) must beSome(MimeTypes.JSON)

      val json = contentAsJson(result)
      (json \ "id").as[String] mustEqual "blah"
    }

    "fail to acquire their details" in new WithApplication {
      val result = Customers.get("Non existing customer ID")(FakeRequest())

      status(result) mustEqual BAD_REQUEST
      contentType(result) must beSome(MimeTypes.JSON)

      val json = contentAsJson(result)
      (json \ "response").as[String] mustEqual "Failed to acquire your details - Contact customer support"
    }
  }
}*/
