import java.io.File

import play.api.Mode.Mode
import play.api.{Configuration, GlobalSettings}
import play.api.mvc.WithFilters
import play.filters.headers.SecurityHeadersFilter

/*
object Global extends WithFilters(SecurityHeadersFilter()) with GlobalSettings {
}*/

object Global extends GlobalSettings {
  override def onLoadConfig(config: Configuration, path: File, classloader: ClassLoader, mode: Mode) = {
    println(s"""===> Owner = ${config.getString("owner")}""")
    super.onLoadConfig(config, path, classloader, mode)
  }
}