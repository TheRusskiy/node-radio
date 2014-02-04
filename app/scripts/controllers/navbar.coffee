"use strict"
angular.module("radioApp").controller "NavbarCtrl", ($scope, $location, Auth, $cookieStore, Socket) ->
  $scope.logout = ->
    Auth.logout().then ->
      $cookieStore.remove "currentUser"
      Socket.reconnect()
      $location.path "/login"


  $scope.isActive = (route) ->
    route is $location.path()

