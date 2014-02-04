(function() {
  "use strict";
  angular.module("radioApp").controller("NavbarCtrl", function($scope, $location, Auth, $cookieStore) {
    $scope.logout = function() {
      return Auth.logout().then(function() {
        $cookieStore.remove("currentUser");
        io.currSocket.disconnect();
        io.currSocket.connect();
        return $location.path("/login");
      });
    };
    return $scope.isActive = function(route) {
      return route === $location.path();
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/navbar.js.map
