'use strict';

angular.module('radioApp')
  .controller 'AppCtrl', ($scope, $http, Auth, $rootScope, Socket, $cookieStore)->
    $rootScope.isAdmin = ()-> $rootScope.currentUser? and $rootScope.currentUser.role is 'admin'
    unless $rootScope.currentUser
      Auth.currentUser().$promise.then( (user)->
        if user._id?
          $rootScope.currentUser = user;
        else
          $rootScope.currentUser = null;
      ).catch( (err)->
        console.log('Current user:'+err.data);
  #        $scope.errors.other = err.message;
      );
    Socket($scope).on 'guest_nickname', (nickname)->
      $rootScope.guestNickname = nickname
      $cookieStore.put('preferredNickname', nickname);