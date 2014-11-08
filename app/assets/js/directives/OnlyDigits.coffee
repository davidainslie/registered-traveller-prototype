@app.directive "onlyDigits", ->
  restrict: "A"
  require: "?ngModel"
  link: (scope, element, attrs, ngModel) ->
    return  unless ngModel
    ngModel.$parsers.unshift (inputValue) ->
      digits = inputValue.replace(/[^\d]/g, "") if inputValue
      ngModel.$viewValue = digits
      ngModel.$render()
      digits



