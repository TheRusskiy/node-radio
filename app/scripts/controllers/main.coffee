"use strict"
angular.module("vivoconfApp").controller "MainCtrl", ($scope, $http) ->
  $http.get("/api/awesomeThings").success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings

