"use strict"
angular.module("radioApp").controller "MainCtrl", ($scope, $http) ->
  $http.get("/api/awesomeThings").success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings

