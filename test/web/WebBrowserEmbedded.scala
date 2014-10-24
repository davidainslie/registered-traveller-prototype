package web

import play.api.test.TestBrowser
import org.openqa.selenium.phantomjs.PhantomJSDriver

trait WebBrowserEmbedded {
  this: WebServer =>

  val browser = TestBrowser.of(classOf[PhantomJSDriver], Some(s"$host:$port"))
}