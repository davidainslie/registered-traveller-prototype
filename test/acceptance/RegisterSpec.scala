/*
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

      Scenario: I pass all the required criteria                                                            ${ Step(startServer()) }
        Given the "invitation code" check                                                                   $s1
        When I "continue" with a valid "invitation code"                                                    $s2
        And I provide my travel details                                                                     $s3
        And I have no criminal offences                                                                     $s4
        And I provide my passport details                                                                   $s5
        And I provide my names regarding my passport                                                        $s6
        And I provide my birth details                                                                      $s7
        And I have an email address                                                                         $s8
        Then I will be presented with a 'summary' of my application                                         $s9
        Then upon accepting the 'declaration' I should be registered and given a confirmation               $s10
                                                                                                            ${ Step(stopServer()) }"""

  def s1 = {
    browser goTo "#/register/invitation-code"
    browser pageSource() must contain("Enter your invitation code")
  }

  def s2 = {
    browser fill "#invitation-code" `with` "BA1111111111"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "What is your nationality as stated on your passport?"
    }
  }

  def s3 = {
    browser click "#nationality option[value='1']"
    browser click "#travel-frequency-achieved-0"
    browser click "#entrance option[value='T1E']"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "Have you ever been refused entry to the UK or had restrictions imposed on your entry?"
    }
  }

  def s4 = {
    browser click "#restrictions-1"
    browser click "#criminal-1"
    browser click "#penalties-1"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "Enter your passport number"
    }
  }

  def s5 = {
    browser fill "#passport-number" `with` "AAAA"
    browser fill "#passport-number-confirm" `with` "AAAA"
    browser fill "#passport-expiry-day" `with` "11"
    browser fill "#passport-expiry-month" `with` "11"
    browser fill "#passport-expiry-year" `with` "2020"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "What is your full name as it appears on your passport?"
    }
  }

  def s6 = {
    browser fill "#surname" `with` "Man"
    browser fill "#given-names" `with` "Bat"
    browser click "#known-by-other-names-1"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "What is your date of birth as stated on your passport?"
    }
  }

  def s7 = {
    browser fill "#dob-day" `with` "11"
    browser fill "#dob-month" `with` "11"
    browser fill "#dob-year" `with` "1990"
    browser click "#gender-0"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "What is your email address?"
    }
  }

  def s8 = {
    browser fill "#email" `with` "batman@gmail.com"
    browser fill "#email-confirm" `with` "batman@gmail.com"
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "Summary"
    }
  }

  def s9 = {
    browser find(".btn", withText("Continue")) click()

    browser.waitUntil {
      browser pageSource() contains "Declaration"
    }
  }

  def s10 = {
    browser click "#declaration"
    browser find(".btn", withText("Submit application")) click()

    browser.waitUntil {
      browser pageSource() contains "Successfully registered"
    }
  }
}*/
