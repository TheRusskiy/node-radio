(function() {
  "use strict";
  angular.module("radioApp").factory("Session", function($resource) {
    return $resource("/api/session/");
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/services/session.js.map
