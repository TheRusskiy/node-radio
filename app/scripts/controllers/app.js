(function() {
  'use strict';
  angular.module('radioApp').controller('AppCtrl', function($scope, $http, Auth, $rootScope, Socket, $cookieStore) {
    $rootScope.isAdmin = function() {
      return ($rootScope.currentUser != null) && $rootScope.currentUser.role === 'admin';
    };
    if (!$rootScope.currentUser) {
      Auth.currentUser().$promise.then(function(user) {
        return $rootScope.currentUser = user;
      })["catch"](function(err) {
        return console.log('Current user:' + err.data);
      });
    }
    return Socket($scope).on('guest_nickname', function(nickname) {
      return $cookieStore.put('preferredNickname', nickname);
    });
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/app.js.map
