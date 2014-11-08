@app.directive "keyFocus", ->
  restrict: "A"
  link: (scope, elem, attrs) ->
    elem.bind "keyup", (e) ->
      if e.keyCode is 38
        # up arrow
        elem[0].previousElementSibling.focus() unless scope.$first
      else if e.keyCode is 40
        # down arrow
        elem[0].nextElementSibling.focus() unless scope.$last



