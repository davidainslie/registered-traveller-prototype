import play.api.GlobalSettings
import play.api.mvc.WithFilters
import play.filters.headers.SecurityHeadersFilter

object Global extends WithFilters(SecurityHeadersFilter()) with GlobalSettings {
}