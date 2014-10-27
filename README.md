Registered Traveller Prototype
==============================

Application built with the following (main) technologies:

- Scala 2.11.2

- SBT 0.13.6

- Play 2.3.4

- Specs2 2.4.2

- AngularJS 1.2.16

- Reactivemongo 0.10.5

Introduction
------------

Scala Play 2 with AngularJS prototype for Registered Traveller and utilising Specs2 and Fluentlenium for acceptance testing.

The essentials of this application show that by removing "layers" of a typical web application, development can be more efficient and yet remain robust.

The web frontend can either be hard coded with AngularJS HTML templates or autogenerated.
The server side is the same regardless of how the frontend is generated by defining domain rules in JSON schemas held in a Mongo datastore.
As well as removing "layers" that cause too many dependencies and maintenance issues, the application is reactive front to back end.
The front end AngularJS HTML templates provide natural distribution (regarding application load) and only communicate, in JSON, with the server side through an exposed RESTful API.
Scala and Play are built to be naturally reactive, scalable, and thread safe, which all aid for easier maintenance.

NOTE that one advantage of hard coding the GUI against a JSON schema is that it can be used now, whereas auto generation needs more work (this is a prototype).
However, no matter the frontend approach, Scala, Play and a Java implementation of the JSON schema make sure that nothing is compromised on the server, which is a top priority, as any hackers will bypass your frontend.

Setup
-----

To get you going with this application, just follow along:

In a directory where you wish to clone this project from git:
> $ git clone https://github.com/davidainslie/registered-traveller-prototype.git

Go into the application's new project directory (with the "cd" shown) and complete the following:
> $ cd registered-traveller-prototype

> $ activator

> [registered-traveller-prototype] $ update-classifiers

OR if you want to see the code in Intellij, as well as run it:

> [registered-traveller-prototype] $ idea sbt-classifiers with-sources=yes

> [registered-traveller-prototype] $ test

Hopefully all (unit) "specs" will pass and you can now open up IntelliJ and start going through the specs and code.

Application - Run
-----------------

This prototype runs against a Mongodb configured for "localhost" on default port 27017.
At the moment there are not "environment" configurations e.g. there is only application.conf and so still to do the likes of application.local.conf etc.

To run the application, seed a locally running Mongodb by doing the following:

> $ cd registered-traveller-prototype

> $ cd mongo

> $ ./schemas-seed.sh

Then run the application:

> $ cd registered-traveller-prototype

> $ activator

> [registered-traveller-prototype] run

And open a browser to localhost:9000

Scala - Benefits
----------------

https://typesafe.com/

- Scalable from writing BASH scripts up to fully concurrent, distributed, reactive, big data, high volume applications

- All important methodologies are inbuilt such as Object Oriented, Functional, Expression Oriented, BDD/TDD, AOP, Actors etc.

- Natural integration with Java and so any 3rd party Java library

- Built in design patterns and encourages good code practices for better maintenance and scalability of applications including functional programming, immutable data, and easier safer concurrency.

Case studies at https://typesafe.com/company/casestudies

Play - Benefits
---------------

https://www.playframework.com/documentation/2.2.x/Philosophy

- Main advantage of any Scala based web library is the Scala language itself e.g. incorporating methodologies such as functional composition, immutability, safe concurrency

- Built for asynchronous programming (reactive); non-blocking I/O. So very easy and inexpensive to make remote calls in parallel, which is important for high performance applications in a service oriented architecture

- Focused on type safety with powerful inbuilt support for JSON, XML and hence easy interaction with remote services

- Datastore and model integration

- RESTful by default

- Hot reload for immediate feedback of any code change

- Easy TDD with embedded servers, browsers, datastores and simple mocks/stubs of 3rd party services

NOTE that another excellent Scala library named Spray, could be used instead of Play, but when I used it, I could not get hot deployment of AngularJS changes to work 

Scala and Play - Some more combined benefits
--------------------------------------------

Acceptance testing - Contained in one file so no disparity errors. Both business and DEVs understand the one file.

Play allows for embedded services allowing acceptance tests to behaviour and run as unit tests.

AngularJS - Benefits
--------------------

https://angularjs.org/

- Powerful JavaScript library whereby a developer has to write far less JavaScript 

- Unlike most other web frameworks/libraries (especially server side tools) AngularJS uses HTML as the templating language; just one of the many benefits that this gives is that Devs keep code in synch with UX

- Makes creating a user interface (UI) easier through data-binding; the two-way binding avoids messy DOM manipulations (unlike JQuery)

- Directives enhance HTML but keeps the HTML declarative (this fits nicely with a declarative JSON schema)

- Angular HTML templates avoid synchronisation of UX HTML and backend templates

- Easy interaction with RESTful services

- Built in support for TDD

- Like all front end libraries with JavaScript, there is natural load balancing of a web application e.g. caching a form until it is ready and reducing remote communications

NOTE (again) that hard coded HTML is fine as the JSON schema defines "the contract" regarding front and back ends and with the business, as again it is a file that the business can read.
Synchronising front and back ends is still straightforward compared to the usual layered applications and security is not compromised as all rules that are defined by the schema are used by the backend.

Possible Alternatives?
----------------------

Node.js has been mentioned as an alternative - there follows some links.

Even though Node.js seems to stand up to the Play Framework (as a direct comparison), the comparisons don't include the benefits of the Scala language itself.
One major issue with Node.js is maintainability - as an application grows and project teams change, maintainability needs to be a top priority.
Another large issue is that one of the prime contributors has left the Node.js community, stating that there are too many issues:

http://bjouhier.wordpress.com/2014/07/05/tj-leaving-node-js/

https://medium.com/code-adventures/farewell-node-js-4ba9e7f3e52b

http://vschart.com/compare/play-framework/vs/node-js

http://www.slideshare.net/mobile/brikis98/nodejs-vs-play-framework

http://brikis98.blogspot.co.uk/2013/11/play-scala-and-iteratees-vs-nodejs.html