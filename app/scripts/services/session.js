(function() {
  "use strict";
  angular.module("vivoconfApp").factory("Session", function($resource) {
    return $resource("/api/session/");
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/services/session.js.map
