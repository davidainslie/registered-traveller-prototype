@app.factory "Scroller", ->
  scrollTo: (id) ->
    idWithoutIndex = id.replace /-\d+/, ""
    target = $("#" + idWithoutIndex)
    $("body,html").animate({scrollTop: target.offset().top - 50}, "slow") # TODO After using nested views I had to add the (- 50), are these related?
    return
    # Explicit return to avoid "Referencing DOM nodes in Angular expressions is disallowed"
    # https://groups.google.com/forum/#!topic/angular/bsTbZ86WAY4

  scrollToLabel: (id) -> @scrollTo "#{id}-label"