(function() {
  "use strict";
  angular.module("vivoconfApp").controller("NavbarCtrl", function($scope, $location, Auth, $cookieStore) {
    $scope.logout = function() {
      return Auth.logout().then(function() {
        $cookieStore.remove("currentUser");
        return $location.path("/login");
      });
    };
    return $scope.isActive = function(route) {
      return route === $location.path();
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/navbar.js.map
