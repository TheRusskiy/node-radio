"use strict"
angular.module("vivoconfApp").controller "NavbarCtrl", ($scope, $location, Auth, $cookieStore) ->
  $scope.menu = [
    title: "Home"
    link: "/"
  ,
    title: "Settings"
    link: "/settings"
  ]
  $scope.logout = ->
    Auth.logout().then ->
      $cookieStore.remove "currentUser"
      $location.path "/login"


  $scope.isActive = (route) ->
    route is $location.path()

