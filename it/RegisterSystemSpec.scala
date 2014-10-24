import org.fluentlenium.core.filter.FilterConstructor._
import org.specs2.mutable.Specification
import web.{WebBrowserEmbedded, WebServer}

/**
 * This "system" spec only works against a running server (e.g. a WebServer that has been manually started).
 */
class RegisterSystemSpec extends Specification with WebServer with WebBrowserEmbedded { override def is = s2"""
  Feature: Register a new traveller
    In order to be a "Registered Traveller"
    As a new customer
    I must provide the required criteria

      Scenario: I pass all the required criteria
        Given the "Eligibility" check                               $s1
        When I "continue" since I am eligible                       $s2
        And provide all remaining required information              $s3
        Then I should be given a confirmation                       $s4"""

  def s1 = {
    browser goTo "#/register/eligibility"
    browser pageSource() must contain("Eligibility")
  }

  def s2 = {
    browser click "#eligible-yes"
    browser.find(".btn", withText("Continue")).click()
    browser pageSource() must contain("1. Travel")
  }

  def s3 = {
    !(browser findFirst "button[type='submit']").isEnabled
    browser click "#nationality option[value='1']"
    browser click "#travel-frequency-achieved-0"
    browser click "#entrance option[value='T1E']"
    (browser findFirst "button[type='submit']").isEnabled
  }

  def s4 = {
    (browser findFirst "button[type='submit']").click()

    browser.waitUntil {
      browser pageSource() contains "Successfully registered"
    }
  }
}