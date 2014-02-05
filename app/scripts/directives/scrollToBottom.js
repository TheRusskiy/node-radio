(function() {
  "use strict";
  /*
  Scroll keep scroll at bottom
  */

  angular.module("radioApp").directive("scrollToBottom", function($interval) {
    return {
      restrict: "A",
      link: function(scope, element, attrs) {
        var messages, scroll;
        messages = attrs.scrollToBottom;
        scroll = function() {
          return element[0].scrollTop = element[0].scrollHeight;
        };
        $interval(scroll, 10, 1, false);
        return scope.$watch(messages, function(newValue, oldValue) {
          console.log('changed');
          return $interval(scroll, 10, 1, false);
        }, true);
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/directives/scrollToBottom.js.map
