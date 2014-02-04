"use strict"
angular.module("radioApp").controller "SignupCtrl", ($scope, Auth, $location, Socket) ->
  $scope.user = {}
  $scope.errors = {}
  $scope.register = (form) ->
    $scope.submitted = true
    if form.$valid

      # Account created, redirect to home
      Auth.createUser(
        nickname: $scope.user.nickname
        password: $scope.user.password
      ).then(->
        Socket.reconnect()
        $location.path "/"
      ).catch (err) ->
        err = err.data
        $scope.errors = {}

        # Update validity of form fields that match the mongoose errors
        angular.forEach err.errors, (error, field) ->
          form[field].$setValidity "mongoose", false
          $scope.errors[field] = error.type

