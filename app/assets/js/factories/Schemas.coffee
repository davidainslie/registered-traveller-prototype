@app.factory "Schemas", ($resource) ->
  schema: (id) ->
    request = $resource("/api/schema/#{id}")
    request.get().$promise