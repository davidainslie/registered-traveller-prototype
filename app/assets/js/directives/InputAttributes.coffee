@app.directive "inputAttributes", ($compile) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    console.log "===> #{angular.toJson(scope.property)}"

    element.attr "xt-validate", ""
    element.attr "name", scope.key
    element.attr "class", "form-control"
    element.attr "data-ng-model", "formData.#{attrs.id}"

    for directive in scope.property.description.split(" ")[1 ..]
      element.attr directive, ""


    ###
    fullKey = scope.property.id.replace(scope.jsonSchema.id, "").replace(/#/g, "").replace(/\//g, "//")

    propertyModel = "data." + scope.property.id.replace(scope.jsonSchema.id, "").replace(/#/g, "").substring(1).replace(/\//g, ".")
    console.log propertyModel
    element.attr "data-ng-model", propertyModel

    scope.$watch (-> element.is ":visible"), ->
      if element.is(":hidden")
        element.val("")
        element.trigger("change")

    element.attr("data-ng-required", true) if scope.required

    minLength = JSON.search(scope.jsonSchema, fullKey + "/minLength")
    element.attr("data-ng-minlength", minLength[0]) if minLength.length > 0

    maxLength = JSON.search(scope.jsonSchema, fullKey + "/maxLength")
    element.attr("data-ng-maxlength", maxLength[0]) if maxLength.length > 0

    pattern = JSON.search(scope.jsonSchema, fullKey + "/pattern")
    element.attr("data-ng-pattern", pattern[0]) if pattern.length > 0
    ###

    element.removeAttr "input-attributes"
    $compile(element) scope