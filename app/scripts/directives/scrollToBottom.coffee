"use strict"

###
Scroll keep scroll at bottom
###
angular.module("radioApp").directive "scrollToBottom", ($interval)->
  return {
    restrict: "A"
    link : (scope, element, attrs) ->
      messages = attrs.scrollToBottom
      scroll = ()-> element[0].scrollTop = element[0].scrollHeight
      $interval scroll, 10, 1, false
      scope.$watch messages, (newValue, oldValue)->
        $interval scroll, 10, 1, false
      , true
  }