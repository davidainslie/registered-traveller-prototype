@app = angular.module('app', ['ngResource', 'ngAnimate', 'ui.router', 'ui.bootstrap', 'mgcrea.ngStrap', 'xtForm', 'toaster'])

# Workaround for bug #1404
# https://github.com/angular/angular.js/issues/1404
@app.config ($provide) ->
  $provide.decorator "ngModelDirective", ($delegate) ->
    ngModel = $delegate[0]
    controller = ngModel.controller

    ngModel.controller = [
      "$scope"
      "$element"
      "$attrs"
      "$injector"
      (scope, element, attrs, $injector) ->
        $interpolate = $injector.get("$interpolate")
        attrs.$set "name", $interpolate(attrs.name or "")(scope)
        $injector.invoke controller, this,
          $scope: scope
          $element: element
          $attrs: attrs
    ]

    $delegate

  $provide.decorator "formDirective", ($delegate) ->
    form = $delegate[0]
    controller = form.controller

    form.controller = [
      "$scope"
      "$element"
      "$attrs"
      "$injector"
      (scope, element, attrs, $injector) ->
        $interpolate = $injector.get("$interpolate")
        attrs.$set "name", $interpolate(attrs.name or attrs.ngForm or "")(scope)
        $injector.invoke controller, this,
          $scope: scope
          $element: element
          $attrs: attrs

    ]

    $delegate

    ###
    var foo = "bar";
    var ob  = {};
    ob[foo] = "something"; // === ob.bar = "something"


    JSPath.apply(".properties.*", json) if json

    values =
      name: "misko"
      gender: "male"

    log = []
    angular.forEach values, ((value, key) ->
      @push key + ": " + value
      return
    ), log
    expect(log).toEqual [
      "name: misko"
      "gender: male"
    ]###

@app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise("/home")

  $stateProvider
    .state("home", {
      url: "/home", templateUrl: "/assets/partials/home.html"
    })
    .state("register", {
      url: "/register", templateUrl: "/assets/partials/register/register.html", controller: "RegisterController"
    })
    .state("register.eligibility", {
      url: "/eligibility", templateUrl: "/assets/partials/register/register-eligibility.html"
    })
    .state("register.particulars", {
      url: "/particulars", templateUrl: "/assets/partials/register/register-particulars.html"
    })
    .state("registered", {
      url: "/registered", templateUrl: "/assets/partials/registered/registered.html", controller: "RegisteredController"
    })
    .state("registered.identify-yourself", {
      url: "/identify-yourself", templateUrl: "/assets/partials/registered/identify-yourself.html"
    })
    .state("customer", {
      url: "/customers/*id", templateUrl: "/assets/partials/single-page-form.html", controller: "CustomersController"
    })
    .state("make-payment", {
      url: "/registered/make-payment", templateUrl: "/assets/partials/registered/make-payment.html", controller: "MakePaymentController"
    })
    .state("single-page-form", {
      url: "/single-page-form/*id", templateUrl: "/assets/partials/single-page-form.html", controller: "SinglePageFormController"
    })