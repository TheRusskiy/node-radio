(function() {
  "use strict";
  angular.module("radioApp").controller("SettingsCtrl", function($scope, User, Auth, $rootScope, Socket) {
    $scope.errors = {};
    $scope.user = {
      nickname: $rootScope.currentUser.nickname
    };
    return $scope.changePassword = function(form) {
      $scope.message = "";
      $scope.submitted = true;
      $scope.passwordUpdate = $scope.user.oldPassword != null;
      if (form.$valid || !$scope.passwordUpdate) {
        return Auth.updateProfile($scope.user).then(function() {
          $scope.message = "Profile successfully updated.";
          $rootScope.currentUser = Auth.currentUser();
          return Socket.reconnect();
        })["catch"](function(err) {
          err = err.data;
          $scope.errors = {};
          angular.forEach(err.errors, function(error, field) {
            form[field].$setValidity("mongoose", false);
            return $scope.errors[field] = error.type;
          });
          $scope.message = "Error updating profile";
          return console.log(err);
        });
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/settings.js.map
