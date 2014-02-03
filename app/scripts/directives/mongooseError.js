(function() {
  "use strict";
  /*
  Removes server error when user updates input
  */

  angular.module("vivoconfApp").directive("mongooseError", function() {
    return {
      restrict: "A",
      require: "ngModel",
      link: function(scope, element, attrs, ngModel) {
        return element.on("keydown", function() {
          return ngModel.$setValidity("mongoose", true);
        });
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/directives/mongooseError.js.map
