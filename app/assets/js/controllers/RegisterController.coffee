@app.controller "RegisterController", ($scope, $state, $stateParams, $modal, $window, toaster, Scroller, Customers) ->
  # TODO Get from a service (from associated schema)
  $scope.entrances = {
    "R": "Indefinite Leave to Remain (ILR)",
    "T1T": "Tier 1: Exceptional Talent/Promise",
    "T1E": "Tier 1: Entrepreneur",
    "T1I": "Tier 1: Investor",
    "T2V": "Tier 2: All categories",
    "none": "None of the above"
  }

  # TODO The following could be generated from a service call to acquire the desired JSON schema
  $scope.formData = {
    eligible: ""
  }

  $scope.eligible = -> $scope.formData.eligible == "yes"

  $scope.notEligible = -> $scope.formData.eligible == "no"

  $scope.continue = (nextState) -> $state.go(nextState) if $scope.form.$valid

  $scope.submit = ->
    if ($scope.form.$valid)
      Customers.register($scope.formData).then(
        (success) ->
          console.info success
          Scroller.scrollTo "form"

          $scope.form.$setPristine()
          $scope.formData = {}

          $modal({title: "Successful Registration", content: success.response, animation: "am-fade-and-scale"})

        (exception) ->
          console.error exception
          Scroller.scrollTo "form"
          $modal({title: "Registration Failure", content: exception.data.response, animation: "am-fade-and-scale"}))
    else
      $scope.submitted = true

      notToSubmit = angular.toJson($scope.formData)
      console.log "NOT Submitting: #{notToSubmit}"

      angular.forEach $("#form").find(".ng-invalid"), (node) ->
        updatedElement = angular.element(document.getElementById("#{node.id}")).removeClass("ng-pristine").addClass("ng-dirty")
        updatedElement.addClass("xt-error") if $("#form").attr("xt-form") != undefined

      Scroller.scrollToLabel($("#form").find(".ng-invalid")[0].getAttribute("id"))
      toaster.pop("error", "Registration Failure", "Amend registration errors (including required missing data).", 5000, "trustedHtml")