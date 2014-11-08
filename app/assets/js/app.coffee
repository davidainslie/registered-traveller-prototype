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

@app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise("/home")

  $stateProvider
    .state("home", {
      url: "/home", templateUrl: "/assets/partials/home.html"
    })
    .state("register", {
        url: "/register", templateUrl: "/assets/partials/register/register.html", controller: "RegisterController"
    })
    .state("register.invitation-code", {
      url: "/invitation-code", templateUrl: "/assets/partials/register/register-invitation-code.html"
    })
    .state("register.travel", {
      url: "/travel", templateUrl: "/assets/partials/register/register-travel.html"
    })
    .state("register.offences", {
      url: "/offences", templateUrl: "/assets/partials/register/register-offences.html"
    })
    .state("register.passport-number", {
      url: "/passport-number", templateUrl: "/assets/partials/register/register-passport-number.html"
    })
    .state("register.passport-names", {
      url: "/passport-names", templateUrl: "/assets/partials/register/register-passport-names.html"
    })
    .state("register.passport-dob", {
      url: "/passport-dob", templateUrl: "/assets/partials/register/register-passport-dob.html"
    })
    .state("register.email", {
      url: "/email", templateUrl: "/assets/partials/register/register-email.html"
    })
    .state("register.summary", {
      url: "/summary", templateUrl: "/assets/partials/register/register-summary.html"
    })
    .state("register.declaration", {
      url: "/declaration", templateUrl: "/assets/partials/register/register-declaration.html"
    })
    .state("register.eligibility-fail", {
      url: "/eligibility-fail", templateUrl: "/assets/partials/register/register-eligibility-fail.html"
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