@app.directive "inputAttributes", ($compile) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    console.log "===> #{angular.toJson(scope.property)}"

    element.attr "xt-validate", ""
    element.attr "name", scope.key
    element.attr "class", "form-control"
    element.attr "data-ng-model", "formData.#{attrs.id}"

    element.attr("data-ng-minlength", scope.property.minLength) if scope.property.minLength?
    element.attr("data-ng-maxlength", scope.property.maxLength) if scope.property.maxLength?

    element.attr("data-ng-pattern", scope.property.pattern) if scope.property.pattern?

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
    ###

    element.removeAttr "input-attributes"
    $compile(element) scope