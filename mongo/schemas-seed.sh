#!/bin/sh
exec scala "$0" "$@"
!#

import java.io._
import scala.io.Source
import scala.sys.process._

object Seed extends App {
  val (host, port, database, collection) = args match {
    case Array(h, p, d, c) => (h, p, d, c)
    case Array(h, p, d) => (h, p, d, "schemas")
    case Array(h, p) => (h, p, "registered-traveller", "schemas")
    case Array(h) => (h, "27017", "registered-traveller", "schemas")
    case _ => ("localhost", "27017", "registered-traveller", "schemas")
  }

  println(s"Executing script against Mongo database: $host:$port/$database")
  s"""mongo --host $host --port $port $database --eval "db.dropDatabase()"""".!

  println(s"Seeding collection: $collection")

  val rootDirectory = "../test/resources/json"

  new File(rootDirectory).listFiles().filter(_.getName.contains("schema")).foreach { seedFile =>
    val seedFileName = seedFile.getName
    val escapedSeedFileName = seedFileName.replaceAll("\\.json", "-escaped.json")

    val pw = new PrintWriter(new File(s"$rootDirectory/$escapedSeedFileName"))

    for (line <- Source.fromFile(s"$rootDirectory/$seedFileName").getLines()) {
      pw.write(line.replaceAll("\\$", ""))
    }

    pw.close()

    s"""mongoimport --host $host --port $port --db $database --collection $collection --jsonArray --file $rootDirectory/$escapedSeedFileName""".!

    new File(s"$rootDirectory/$escapedSeedFileName").delete()
  }
}

Seed.main(args)