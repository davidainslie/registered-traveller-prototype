@app.controller "MakePaymentController", ($scope, $state, $stateParams, $modal, $window, toaster, Scroller) ->
  $scope.startPayment = ->
    $scope.gatewayOpen = true