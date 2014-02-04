"use strict"
angular.module("radioApp").controller "NavbarCtrl", ($scope, $location, Auth, $cookieStore) ->
  $scope.logout = ->
    Auth.logout().then ->
      $cookieStore.remove "currentUser"
      $location.path "/login"


  $scope.isActive = (route) ->
    route is $location.path()

