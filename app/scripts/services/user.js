(function() {
  "use strict";
  angular.module("vivoconfApp").factory("User", function($resource) {
    return $resource("/api/users/:id", {
      id: "@id"
    }, {
      update: {
        method: "PUT",
        params: {}
      },
      get: {
        method: "GET",
        params: {
          id: "me"
        }
      }
    });
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/services/user.js.map
