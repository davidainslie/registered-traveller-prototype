Registered Traveller Prototype
==============================

Application built with the following (main) technologies:

- Scala 2.11.2

- SBT 0.13.6

- Play 2.3.4

- Specs2 2.4.2

- AngularJS 1.2.16

Introduction
------------

Scala Play 2 with AngularJS prototype for Registered Traveller

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

Scala - Benefits
----------------

https://typesafe.com/

- Scalable from writing BASH scripts up to fully concurrent, distributed, reactive, big data, high volume applications

- All important methodologies are inbuilt such as Object Oriented, Functional, Expression Oriented, BDD/TDD, AOP, Actors etc.

- Natural integration with Java and so any 3rd party Java library

- Built in design patterns and encourages good code practices for better maintenance and scalability of applications including functional programming, immutable data, and easier safer concurrency.

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

- NOTE that another excellent Scala library named Spray, could be used instead of Play, but when I used it, I could not get hot deployment of AngularJS changes to work 

AngularJS Benefits
------------------

https://angularjs.org/

- Powerful JavaScript library whereby a developer has to write far less JavaScript 

- Unlike most other web frameworks/libraries (especially server side tools) AngularJS uses HTML as the templating language; just one of the many benefits that this gives is that Devs keep code in synch with UX

- Makes creating a user interface (UI) easier through data-binding; the two-way binding avoids messy DOM manipulations (unlike JQuery)

- Directives enhance HTML but keeps the HTML declarative (this fits nicely with a declarative JSON schema)

- Angular HTML templates avoid synchronisation of UX HTML and backend templates

- Easy interaction with RESTful services

- Built in support for TDD

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