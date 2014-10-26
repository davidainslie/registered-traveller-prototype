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

      angular.forEach $scope.schema.properties,
        ((value, key) ->
          property = {}
          property["id"] = key

          for p of value
            property[p] = value[p]

          @push property),
        $scope.schemaProperties

    (exception) ->
      console.error exception
      $modal({ title: "Customer Details Acquisition Failure", content: "#{$stateParams.id}: #{exception.data.response}", animation: "am-fade-and-scale" }))

  #$scope.evalModel = (model) -> $scope.$eval("formData." + model)

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

  $scope.inputType = (property) ->
    property.description.split(" ")[0] if property.description