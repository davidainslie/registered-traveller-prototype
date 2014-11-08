@app.controller "RegisterController", ($scope, $state, $stateParams, $modal, $window, toaster, Scroller, Customers) ->
  # TODO Get from associated schema (or from a service)
  $scope.entrances = {
    "R": "Indefinite Leave to Remain (ILR)",
    "T1T": "Tier 1: Exceptional Talent/Promise",
    "T1E": "Tier 1: Entrepreneur",
    "T1I": "Tier 1: Investor",
    "T2V": "Tier 2: All categories",
    "none": "None of the above"
  }

  # TODO Get from associated schema (or from a service)
  $scope.reasons = {
    "ENV": "Entertainer visitor",
    "STV": "Sports visitor",
    "BV": "Business visitor",
    "V": "Tourist",
    "VPC": "Parents of children at school in the UK",
    "none": "None of the above"
  }

  $scope.formData = {}

  withValidForm = (f) ->
    if (!$scope.form.$pristine && $scope.form.$valid)
      f()
    else
      angular.forEach $("#form").find(".ng-invalid"), (node) ->
        updatedElement = angular.element(document.getElementById("#{node.id}")).removeClass("ng-pristine").addClass("ng-dirty")
        updatedElement.addClass("xt-error") if $("#form").attr("xt-form") != undefined

      Scroller.scrollToLabel($("#form").find(".ng-invalid")[0].getAttribute('id'))
      toaster.pop("error", "Failure", "Amend errors (including required missing data).", 5000, "trustedHtml")

  $scope.continue = (nextState) ->
    $state.go(nextState) if $scope.form.$valid

  $scope.validateInvitationCode = (nextState) ->
    withValidForm(->
      Customers.invitationCode($scope.formData.invitationCode).then(
        (success) ->
          console.log angular.toJson(success)

          if (success.invitationCode.status != "UNREDEEMED")
            $modal({title: "Invitation Code Failure", content: "This code has already been taken or has expired", animation: "am-fade-and-scale"})
          else
            $scope.continue(nextState)

        (exception) ->
          console.log "EXCEPTION: #{angular.toJson(exception)}"
          $modal({title: "Invitation Code Failure", content: exception.data.error, animation: "am-fade-and-scale"})))

  $scope.validateTravel = (nextState) ->
    withValidForm(->
      $scope.errors = []
      $scope.errors.push("Currently to be a registered traveller you have to hold a valid passport from one of the following countries: Australia, Canada, Japan, New Zealand or the USA. You have said that you do not hold one of these passports.") if $scope.formData.travel.nationality == "None of the above"
      $scope.errors.push("The Registered Traveller Service is for frequent travellers to the UK. To be eligible you must have travelled to the UK at least 4 times in the last 52 weeks. Come back and apply again if you start travelling to the UK more frequently.") if $scope.formData.travel.frequencyAchieved == "no"
      $scope.errors.push("The Registered Traveller Service is only available to those travelling for certain purposes or with certain visa types. Your reason for travel to the UK does not currently qualify. This does not affect your right to seek leave to enter the UK through normal channels.") if $scope.formData.travel.entrance == "none" && $scope.formData.travel.reason == "none"

      if $scope.errors.length > 0
        $scope.continue("register.eligibility-fail")
      else
        $scope.continue(nextState))

  $scope.validateOffences = (nextState) ->
    withValidForm(->
      $scope.errors = []
      $scope.errors.push("This service currently operates a zero tolerance policy, and you have indicated that you have previously been refused entry or had restrictions imposed on you. This does not affect your right to seek leave to enter the UK through normal channels. More about entering the UK") if $scope.formData.offences.restrictions == "yes"
      $scope.errors.push("This service currently operates a zero tolerance policy, and you have indicated that you have previously been cautioned or convicted. This does not affect your right to seek leave to enter the UK through normal channels. More about entering the UK") if $scope.formData.offences.criminal == "yes"
      $scope.errors.push("This service operates a zero tolerance policy, and you have indicated that you have previously had action or penalties against you for breaking customs laws or regulations. This does not affect your right to seek leave to enter the UK through normal channels. More about entering the UK") if $scope.formData.offences.penalties == "yes"

      if $scope.errors.length > 0
        $scope.continue("register.eligibility-fail")
      else
        $scope.continue(nextState))

  $scope.validateDate = (date) ->
    return if !date

  $scope.validatePassportNumber = (nextState) ->
    withValidForm(->
      $scope.continue(nextState))

  $scope.validatePassportNames = (nextState) ->
    console.log "valiating passport names"

    console.log "Submitting: #{angular.toJson($scope.formData)}"

    withValidForm(->
      $scope.continue(nextState))

  $scope.go = (nextState, shouldValidate) ->
    console.log "Going..."
    if shouldValidate
      withValidForm(->
        $scope.continue(nextState))
    else
      $scope.continue(nextState)

  $scope.passportNumbersCorrelate = ->
    if $scope.formData.passport? and $scope.formData.passport.passportNumber? and $scope.formData.passport.passportNumberConfirm
      $scope.formData.passport.passportNumber.length == 0 || $scope.formData.passport.passportNumberConfirm.length == 0 || ($scope.formData.passport.passportNumber == $scope.formData.passport.passportNumberConfirm)
    else
      true

  $scope.emailsCorrelate = ->
    if $scope.formData.email? and $scope.formData.emailConfirm
      $scope.formData.email.length == 0 || $scope.formData.emailConfirm.length == 0 || ($scope.formData.email == $scope.formData.emailConfirm)
    else
      true

  $scope.validatePassportExpiryDate = (dd, mm, yyyy) ->
    return if !dd || !mm || !yyyy

    yyyyInt = parseInt(yyyy)

    if yyyyInt < 2014 or yyyyInt > 2034
      console.log "invalid passport expiry date"
      $scope.dateValidationError = "You need to enter a valid passport expiry date"
      return false

    $scope.validateDate(dd,mm,yyyy)

  $scope.validateDOB = (dd, mm, yyyy) ->
    return if !dd || !mm || !yyyy

    yyyyInt = parseInt(yyyy)

    if yyyyInt > 1996 or yyyyInt < 1900
      console.log "invalid DOB"
      $scope.dateValidationError = "You need to be over 18 and under 114 to join this service"
      return false

    $scope.validateDate(dd,mm,yyyy)

  $scope.validateDate = (dd, mm, yyyy) ->
    dd = parseInt(dd)
    mm = parseInt(mm)
    yyyy = parseInt(yyyy)

    console.log "validating input fields: #{dd}/#{mm}/#{yyyy}"
    daysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]

    validDate = true
    if mm < 1 or dd < 1 or mm > 12 or dd > 31
      validDate = false
    else if mm is 1 or mm > 2
      if dd > daysInMonth[mm]
        validDate =  false
    else if mm is 2
      lyear = false
      lyear = true  if (not (yyyy % 4) and yyyy % 100) or not (yyyy % 400)
      if (lyear is false) and (dd > 28)
        validDate = false
      if (lyear is true) and (dd > 29)
        validDate = false

    if validDate
      console.log "valid date"
      $scope.dateValidationError = undefined
      true
    else
      console.log "invalid date"
      $scope.dateValidationError = "You need to enter a valid date"
      false

  $scope.submit = ->
    withValidForm(->
      console.log "Submitting: #{angular.toJson($scope.formData)}"

      Customers.register($scope.formData).then(
        (success) ->
          console.info success
          Scroller.scrollTo "form"

          $scope.form.$setPristine()
          $scope.formData = {}

          $modal({title: "Successful Registration", content: success.response, animation: "am-fade-and-scale"})

        (exception) ->
          console.error exception
          $scope.continue("register.eligibility-fail")))