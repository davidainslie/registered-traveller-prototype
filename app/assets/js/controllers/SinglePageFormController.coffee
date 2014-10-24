@app.controller "SinglePageFormController", ($scope, $state, $stateParams, $modal, $window, toaster, Scroller, Schemas) ->
  $scope.evaluateModel = true

  $scope.formData = {}

  $scope.id = $stateParams.id

  Schemas.schema($scope.id).then(
    (success) ->
      console.info success
      $scope.form = angular.fromJson(success)
      $scope.formData.id = $scope.form.id
      # $scope.hasFee = $scope.licenceDefinition.fee?

    (exception) ->
      console.error exception
      $modal({ title: "Invalid Form", content: "#{$scope.id}: #{exception.statusText}", animation: "am-fade-and-scale" }))

  $scope.evalModel = (model) -> $scope.$eval("formData." + model)