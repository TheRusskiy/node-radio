(function() {
  "use strict";
  angular.module("radioApp").controller("LoginCtrl", function($scope, Auth, $location, User, $rootScope, $cookieStore) {
    $scope.user = {};
    $scope.errors = {};
    $scope.vkLogin = function() {
      return Auth.vkLogin(function(data) {
        alert(JSON.stringify(data));
        return $scope.$apply(function() {
          io.currSocket.disconnect();
          io.currSocket.connect();
          $rootScope.currentUser = new User(data);
          return $location.path("/");
        });
      });
    };
    $scope.fbLogin = function() {
      return Auth.fbLogin(function(data) {
        alert(JSON.stringify(data));
        return $scope.$apply(function() {
          io.currSocket.disconnect();
          io.currSocket.connect();
          $rootScope.currentUser = new User(data);
          return $location.path("/");
        });
      });
    };
    return $scope.login = function(form) {
      $scope.submitted = true;
      if (form.$valid) {
        return Auth.login({
          nickname: $scope.user.nickname,
          password: $scope.user.password
        }).then(function() {
          io.currSocket.disconnect();
          io.currSocket.connect();
          return $location.path("/");
        })["catch"](function(err) {
          err = err.data;
          return $scope.errors.other = err.message;
        });
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/login.js.map
