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

- Built for asynchronous programming (reactive); non-blocking I/O. So very easy and inexpensive to make remote calls in parallel, which is important for high performance applications in a service oriented architecture

- Focused on type safety with powerful inbuilt support for JSON, XML and hence easy interaction with remote services

- Datastore and model integration

- RESTful by default

- Hot reload for immediate feedback of any code change

- Easy TDD with embedded servers, browsers, datastores and simple mocks/stubs of 3rd party services

AngularJS Benefits
------------------

https://angularjs.org/

- Unlike most other web frameworks/libraries (especially server side tools) AngularJS uses HTML as the templating language; just one of the many benefits that this gives is that Devs keep code in synch with UX

- Makes creating a user interface (UI) easier through data-binding

- Easy interaction with RESTful services

- Built in support for TDD