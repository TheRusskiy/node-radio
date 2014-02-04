(function() {
  "use strict";
  angular.module("radioApp").controller("LoginCtrl", function($scope, Auth, $location, User, $rootScope, $cookieStore) {
    $scope.user = {};
    $scope.errors = {};
    $scope.vkLogin = function() {
      return Auth.vkLogin(function(data) {
        alert(JSON.stringify(data));
        return $scope.$apply(function() {
          return $rootScope.currentUser = new User(data);
        });
      });
    };
    $scope.fbLogin = function() {
      return Auth.fbLogin(function(data) {
        alert(JSON.stringify(data));
        return $scope.$apply(function() {
          return $rootScope.currentUser = new User(data);
        });
      });
    };
    return $scope.login = function(form) {
      $scope.submitted = true;
      if (form.$valid) {
        return Auth.login({
          email: $scope.user.email,
          password: $scope.user.password
        }).then(function() {
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
