(function() {
  "use strict";
  angular.module("vivoconfApp").factory("Conference", function($resource) {
    return $resource("/api/conferences/:id", {
      id: "@id"
    }, {
      update: {
        method: "PUT",
        params: {}
      },
      query: {
        method: 'GET',
        isArray: true
      }
    });
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/services/conference.js.map
