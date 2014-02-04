"use strict"
angular.module("radioApp").controller "LoginCtrl", ($scope, Auth, $location, User, $rootScope, $cookieStore, Socket) ->
  $scope.user = {}
  $scope.errors = {}
  $scope.vkLogin = ->
    Auth.vkLogin (data) ->
      alert JSON.stringify(data)
      $scope.$apply ->
        Socket.reconnect()
        $rootScope.currentUser = new User(data)
        $location.path "/"
  #            $cookieStore.put('currentUser', $rootScope.currentUser);


  $scope.fbLogin = ->
    Auth.fbLogin (data) ->
      alert JSON.stringify(data)
      $scope.$apply ->
        Socket.reconnect()
        $rootScope.currentUser = new User(data)
        $location.path "/"


  #            $cookieStore.put('currentUser', $rootScope.currentUser);
  $scope.login = (form) ->
    $scope.submitted = true
    if form.$valid
      Auth.login(
        nickname: $scope.user.nickname
        password: $scope.user.password
      ).then ()->
        # Logged in, redirect to home
        Socket.reconnect()
        $location.path "/"
      .catch (err)->
        err = err.data;
        $scope.errors.other = err.message;
