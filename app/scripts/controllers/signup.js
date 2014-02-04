(function() {
  "use strict";
  angular.module("radioApp").controller("SignupCtrl", function($scope, Auth, $location, Socket) {
    $scope.user = {};
    $scope.errors = {};
    return $scope.register = function(form) {
      $scope.submitted = true;
      if (form.$valid) {
        return Auth.createUser({
          nickname: $scope.user.nickname,
          password: $scope.user.password
        }).then(function() {
          Socket.reconnect();
          return $location.path("/");
        })["catch"](function(err) {
          err = err.data;
          $scope.errors = {};
          return angular.forEach(err.errors, function(error, field) {
            form[field].$setValidity("mongoose", false);
            return $scope.errors[field] = error.type;
          });
        });
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/signup.js.map
