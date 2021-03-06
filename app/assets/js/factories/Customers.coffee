@app.factory "Customers", ($resource) ->
  invitationCode: (id) ->
    console.debug "Customers.invitationCode: #{id}"
    request = $resource "/api/invitation-codes/#{id}"
    request.get().$promise

  register: (customer) ->
    console.debug "Customers.register: #{angular.toJson(customer, true)}"
    request = $resource "/api/customers"
    request.save(customer).$promise

  get: (id) ->
    console.debug "Customers.get: #{id}"
    request = $resource "/api/customers/#{id}"
    request.get().$promise

  update: (customer) ->
    console.debug "Customers.update: #{angular.toJson(customer, true)}"
    request = $resource "/api/customers", {}, update: method: "PUT"
    request.update(customer).$promise