(function() {
  "use strict";
  angular.module("vivoconfApp").controller("SettingsCtrl", function($scope, User, Auth) {
    $scope.errors = {};
    return $scope.changePassword = function(form) {
      $scope.submitted = true;
      if (form.$valid) {
        return Auth.changePassword($scope.user.oldPassword, $scope.user.newPassword).then(function() {
          return $scope.message = "Password successfully changed.";
        })["catch"](function() {
          form.password.$setValidity("mongoose", false);
          return $scope.errors.other = "Incorrect password";
        });
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/settings.js.map
