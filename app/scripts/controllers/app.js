(function() {
  'use strict';
  angular.module('radioApp').controller('AppCtrl', function($scope, $http, Auth, $rootScope) {
    $rootScope.isAdmin = function() {
      return ($rootScope.currentUser != null) && $rootScope.currentUser.role === 'admin';
    };
    if (!$rootScope.currentUser) {
      return Auth.currentUser().$promise.then(function(user) {
        return $rootScope.currentUser = user;
      })["catch"](function(err) {
        return console.log('Current user:' + err.data);
      });
    }
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/app.js.map
