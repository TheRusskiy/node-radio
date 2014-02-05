'use strict';

angular.module('radioApp')
  .controller 'AppCtrl', ($scope, $http, Auth, $rootScope, Socket, $cookieStore)->
    $rootScope.isAdmin = ()-> $rootScope.currentUser? and $rootScope.currentUser.role is 'admin'
    unless $rootScope.currentUser
      Auth.currentUser().$promise.then( (user)->
        $rootScope.currentUser = user;
      ).catch( (err)->
        console.log('Current user:'+err.data);
  #        $scope.errors.other = err.message;
      );
    Socket($scope).on 'guest_nickname', (nickname)->
      $cookieStore.put('preferredNickname', nickname);