package web

import play.api.test.TestServer
import de.flapdoodle.embed.process.runtime.Network

trait WebServerEmbedded extends WebServer {
  override val port = Network.getFreeServerPort

  val server = TestServer(port)

  def startServer() = server.start()

  def stopServer() = server.stop()
}