"use strict"
angular.module("radioApp").controller "SettingsCtrl", ($scope, User, Auth, $rootScope, Socket) ->
  $scope.errors = {}
  $scope.user = {nickname: $rootScope.currentUser.nickname}
  $scope.changePassword = (form) ->
    $scope.message = ""
    $scope.submitted = true
    $scope.passwordUpdate = $scope.user.oldPassword?
    oldNickname = $rootScope.currentUser.nickname
    if form.$valid or not $scope.passwordUpdate
      Auth.updateProfile($scope.user).then(->
        $scope.message = "Profile successfully updated."
        Socket.reconnect()
        $rootScope.currentUser = Auth.currentUser()
        Auth.currentUser().$promise.then( (user)->
          if user._id?
            $rootScope.currentUser = user;
            newNickname = $rootScope.currentUser.nickname
            if oldNickname isnt newNickname then Socket($scope).emit "nickname_changed", {oldNickname, newNickname}
          else
            $rootScope.currentUser = null;
        ).catch( (err)->
          console.log('Current user:'+err.data);
          #        $scope.errors.other = err.message;
        );
      ).catch (err)->
        err = err.data
        $scope.errors = {}

        # Update validity of form fields that match the mongoose errors
        angular.forEach err.errors, (error, field) ->
          form[field].$setValidity "mongoose", false
          $scope.errors[field] = error.type
        $scope.message = "Error updating profile"
        console.log err

