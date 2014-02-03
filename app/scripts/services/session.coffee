"use strict"
angular.module("vivoconfApp").factory "Session", ($resource) ->
  $resource "/api/session/"
