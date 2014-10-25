@app.directive "uppercase", ->
  require: "ngModel"

  link: (scope, element, attrs, modelCtrl) ->
    capitalize = (inputValue) ->
      inputValue = ""  unless inputValue?
      capitalized = inputValue.toUpperCase()

      if capitalized isnt inputValue
        modelCtrl.$setViewValue capitalized
        modelCtrl.$render()

      capitalized

    modelCtrl.$parsers.push capitalize
    capitalize scope[attrs.ngModel]