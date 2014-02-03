'use strict';

angular.module('vivoconfApp')
  .controller 'AppCtrl', ($scope, $http, Auth, $rootScope)->
    unless $rootScope.currentUser
      Auth.currentUser().$promise.then( (user)->
        $rootScope.currentUser = user;
      ).catch( (err)->
        console.log('Current user:'+err.data);
  #        $scope.errors.other = err.message;
      );
