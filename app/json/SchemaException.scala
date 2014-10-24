package json

case class SchemaException(errorMessages: Seq[String]) extends Exception {
  def this(errorMessage: String) = this(Seq(errorMessage))

  override def getMessage = errorMessages.mkString(", ")
}