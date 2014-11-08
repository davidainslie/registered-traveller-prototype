import com.typesafe.sbt.web.SbtWeb.autoImport._
import com.typesafe.sbt.less.Import.LessKeys
import play.PlayScala
import com.typesafe.sbt.SbtNativePackager._
import NativePackagerKeys._

name := "registered-traveller-prototype"

organization := "kissthinker"

version := "1.0-SNAPSHOT"

scalaVersion := "2.11.2"

scalacOptions ++= Seq(
  "-feature",
  "-deprecation",
  "-unchecked",
  "-Xlint",
  "-language:implicitConversions",
  "-language:higherKinds",
  "-language:existentials",
  "-language:reflectiveCalls",
  "-language:postfixOps"
)

resolvers ++= Seq(
  "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases/",
  "Sonatype Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots/"
)

libraryDependencies ++= Seq(ws, filters)

libraryDependencies ++= Seq(
  "org.webjars" %% "webjars-play" % "2.3.0-2",
  "org.webjars" % "bootstrap" % "3.1.1-2",
  "org.reactivemongo" %% "play2-reactivemongo" % "0.10.5.0.akka23",
  "com.github.fge" % "json-schema-validator" % "2.2.5",
  "com.itextpdf" % "itextpdf" % "5.5.2",
  "com.squants" %% "squants" % "0.4.2",
  "org.joda" % "joda-money" % "0.9.1"
)

libraryDependencies ++= Seq(
  "org.scalamock" % "scalamock-specs2-support_2.11" % "3.1.2" % "test, it",
  "de.flapdoodle.embed" % "de.flapdoodle.embed.mongo" % "1.46.1" % "test, it",
  "com.github.detro.ghostdriver" % "phantomjsdriver" % "1.1.0" % "test, it",
  "com.typesafe.akka" %% "akka-testkit" % "2.3.4" % "test, it",
  "org.mockito" % "mockito-core" % "1.9.5" % "test, it",
  "com.github.fakemongo" % "fongo" % "1.5.5" % "test, it",
  "org.scalatest" %% "scalatest" % "2.2.1" % "test, it",
  "com.github.fakemongo" % "fongo" % "1.5.5" % "test, it"
)

// lazy val root = (project in file(".")).addPlugins(PlayScala)
lazy val root = (project in file("."))
  .enablePlugins(PlayScala)
  .configs(IntegrationTest)
  .settings(Defaults.itSettings: _*)

scalaSource in IntegrationTest := baseDirectory.value / "it"

// pipelineStages := Seq(rjs, digest, gzip)

includeFilter in (Assets, LessKeys.less) := "*.less"

excludeFilter in (Assets, LessKeys.less) := "_*.less"

// For minified *.min.css files
// LessKeys.compress := true

maintainer in Docker := "David Ainslie <dainslie@gmail.com>"

// exposing the play ports
dockerExposedPorts in Docker := Seq(9000, 9443)