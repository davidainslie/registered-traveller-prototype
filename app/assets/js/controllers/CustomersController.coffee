@app.controller "CustomersController", ($scope, $state, $stateParams, $modal, $window, toaster, Scroller, Customers) ->
  #$scope.evaluateModel = true

  $scope.schema = {}
  $scope.schemaProperties = []
  $scope.formData = {}

  Customers.get($stateParams.id).then(
    (success) ->
      console.info success
      $scope.schema = success.schema
      console.log("Schema acquired = #{angular.toJson($scope.schema)}")
      $scope.formData = success.data if success.data
      console.log("Form data acquired = #{angular.toJson($scope.formData)}")

      angular.forEach $scope.schema.properties, ((value, key) ->
          property = {}
          property[key] = value
          console.log "THE KEY = #{key}"

          @push property),
        $scope.schemaProperties

      console.log "SET PROPERITIES"

    (exception) ->
      console.error exception
      $modal({ title: "Customer Details Acquisition Failure", content: "#{$stateParams.id}: #{exception.data.response}", animation: "am-fade-and-scale" }))

  #$scope.evalModel = (model) -> $scope.$eval("formData." + model)

  $scope.isInput = (property) ->
    JSPath.apply("..description", property).length > 0

  $scope.inputType = (property) ->
    console.log JSPath.apply("..description", property)
    JSPath.apply("..description", property)[0].split(" ")[0] if $scope.isInput(property)

  $scope.xxx = ->
    console.log "GETTING PROPERITIES #{angular.toJson($scope.schemaProperties)}"
    $scope.schemaProperties

  $scope.submit = ->
    if ($scope.form.$valid)
      Customers.update($scope.formData).then(
        (success) ->
          console.info success
          Scroller.scrollTo "form"

          $scope.form.$setPristine()
          $scope.formData = {}

          $modal({title: "Successful Update", content: success.response, animation: "am-fade-and-scale"})

        (exception) ->
          console.error exception
          Scroller.scrollTo "form"
          $modal({title: "Update Failure", content: exception.data.response, animation: "am-fade-and-scale"}))
    else
      $scope.submitted = true

      notToSubmit = angular.toJson($scope.formData)
      console.log "NOT Submitting: #{notToSubmit}"

      angular.forEach $("#form").find(".ng-invalid"), (node) ->
        updatedElement = angular.element(document.getElementById("#{node.id}")).removeClass("ng-pristine").addClass("ng-dirty")
        updatedElement.addClass("xt-error") if $("#form").attr("xt-form") != undefined

      Scroller.scrollToLabel($("#form").find(".ng-invalid")[0].getAttribute("id"))
      toaster.pop("error", "Update Failure", "Amend update errors (including required missing data).", 5000, "trustedHtml")