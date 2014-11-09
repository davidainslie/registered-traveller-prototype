package controllers

import play.api.http.MimeTypes
import play.api.libs.json.Json
import play.api.mvc.Controller
import play.api.test._
import json._

class CustomersSpec extends PlaySpecification {
  skipAll

  object Customers extends Controller with Customers

  "Customer" should {
    /*"acquire their details" in new WithApplication {
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
    }*/

    "acquire their invitation code" in new WithApplication {
      val result = Customers.invitationCode("BA1111111111")(FakeRequest())

      status(result) mustEqual OK
      contentType(result) must beSome(MimeTypes.JSON)

      val json = contentAsJson(result)
      (json \ "invitationCode" \ "_id").as[String] mustEqual "BA1111111111"
      (json \ "invitationCode" \ "status").as[String] mustEqual "UNREDEEMED"
    }

    "fail to acquire their non exisiting invitation code" in new WithApplication {
      val result = Customers.invitationCode("XX1111111111")(FakeRequest())

      status(result) mustEqual NOT_FOUND
      contentType(result) must beSome(MimeTypes.JSON)

      val json = contentAsJson(result)
      (json \ "error").as[String] mustEqual "Invitation code was not found"
    }

    "not be able to register when providing no information" in new WithApplication {
      val request = FakeRequest().withBody(Json.obj())

      val result = Customers.register(request)
      status(result) mustEqual BAD_REQUEST
    }

    "register when providing all information" in new WithApplication {
      val registerJson = json(fromClasspath("/json/register.json"))
      val request = FakeRequest().withBody(registerJson)

      val result = Customers.register(request)
      status(result) mustEqual CREATED
    }
  }
}