(function() {
  "use strict";
  angular.module("radioApp").controller("NavbarCtrl", function($scope, $location, Auth, $cookieStore, Socket) {
    $scope.logout = function() {
      return Auth.logout().then(function() {
        $cookieStore.remove("currentUser");
        Socket.reconnect();
        return $location.path("/login");
      });
    };
    return $scope.isActive = function(route) {
      return route === $location.path();
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/navbar.js.map
