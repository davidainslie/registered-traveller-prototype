package acceptance

import org.specs2.mutable.Specification
import org.specs2.specification.Step
import org.fluentlenium.core.filter.FilterConstructor._
import web.{WebBrowserEmbedded, WebServerEmbedded}

class RegisterSpec extends Specification with WebServerEmbedded with WebBrowserEmbedded { override def is = s2"""
  Feature: Register a new traveller
    In order to be a "Registered Traveller"
    As a new customer
    I must provide the required criteria

      Scenario: I pass all the required criteria                        ${ Step(startServer()) }
        Given the "Eligibility" check                                   $s1
        When I "continue" since I am eligible                           $s2
        And provide all remaining required information                  $s3
        Then I should be registered and given a confirmation            $s4
                                                                        ${ Step(stopServer()) }"""

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