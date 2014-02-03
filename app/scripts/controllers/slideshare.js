(function() {
  'use strict';
  angular.module('vivoconfApp').controller('SlideshareCtrl', function($scope, Socket, $http, $rootScope) {
    $scope.errors = {};
    $scope.user = {};
    return $scope["import"] = function(form) {
      $scope.submitted = true;
      if (form.$valid) {
        console.log('Sending: ' + $scope.slidesUrl);
        return $http.post("/api/conferences/" + $rootScope.conference_id + "/slides", {
          slides_url: $scope.slidesUrl
        }).then(function(response) {
          return alert(JSON.stringify(response));
        })["catch"](function(err) {
          return alert(JSON.stringify(err));
        });
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/slideshare.js.map
