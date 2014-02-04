"use strict"
angular.module("radioApp").controller "NavbarCtrl", ($scope, $location, Auth, $cookieStore) ->
  $scope.logout = ->
    Auth.logout().then ->
      $cookieStore.remove "currentUser"
      io.currSocket.disconnect()
      io.currSocket.connect()
      $location.path "/login"


  $scope.isActive = (route) ->
    route is $location.path()

