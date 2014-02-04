"use strict"
angular.module("radioApp").controller "LoginCtrl", ($scope, Auth, $location, User, $rootScope, $cookieStore) ->
  $scope.user = {}
  $scope.errors = {}
  $scope.vkLogin = ->
    Auth.vkLogin (data) ->
      alert JSON.stringify(data)
      $scope.$apply ->
        $rootScope.currentUser = new User(data)
  #            $cookieStore.put('currentUser', $rootScope.currentUser);


  $scope.fbLogin = ->
    Auth.fbLogin (data) ->
      alert JSON.stringify(data)
      $scope.$apply ->
        $rootScope.currentUser = new User(data)


  #            $cookieStore.put('currentUser', $rootScope.currentUser);
  $scope.login = (form) ->
    $scope.submitted = true
    if form.$valid
      Auth.login(
        email: $scope.user.email
        password: $scope.user.password
      ).then ()->
        # Logged in, redirect to home
        $location.path "/"
      .catch (err)->
        err = err.data;
        $scope.errors.other = err.message;
