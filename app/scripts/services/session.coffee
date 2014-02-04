"use strict"
angular.module("radioApp").factory "Session", ($resource) ->
  $resource "/api/session/"
