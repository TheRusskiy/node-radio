"use strict"
angular.module("radioApp").controller "SettingsCtrl", ($scope, User, Auth, $rootScope, Socket) ->
  $scope.errors = {}
  $scope.user = {nickname: $rootScope.currentUser.nickname}
  $scope.changePassword = (form) ->
    $scope.message = ""
    $scope.submitted = true
    $scope.passwordUpdate = $scope.user.oldPassword?
    if form.$valid or not $scope.passwordUpdate
      Auth.updateProfile($scope.user).then(->
        $scope.message = "Profile successfully updated."
        $rootScope.currentUser = Auth.currentUser()
        Socket.reconnect()
      ).catch (err)->
        err = err.data
        $scope.errors = {}

        # Update validity of form fields that match the mongoose errors
        angular.forEach err.errors, (error, field) ->
          form[field].$setValidity "mongoose", false
          $scope.errors[field] = error.type
        $scope.message = "Error updating profile"
        console.log err

