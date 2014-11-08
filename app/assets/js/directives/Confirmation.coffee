@app.directive "equals", ->
  restrict: "A" # only activate on element attribute
  require: "?ngModel" # get a hold of NgModelController
  link: (scope, elem, attrs, ngModel) ->
    return unless ngModel # do nothing if no ng-model

    # watch own value and re-validate on change
    scope.$watch attrs.ngModel, ->
      validate()

    # observe the other value and re-validate on change
    attrs.$observe "equals", ->
      validate()

    validate = ->
      val1 = ngModel.$viewValue
      val2 = attrs.equals

      # set validity
      ngModel.$setValidity "equals", not val1 or not val2 or val1 is val2