(function() {
  'use strict';
  angular.module('vivoconfApp').controller('ConferenceCtrl', function($scope, Conference, $routeParams, $rootScope) {
    var conference_id;
    conference_id = $routeParams.id;
    $scope.conference = Conference.get({
      id: conference_id
    });
    return $rootScope.conference_id = conference_id;
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/conference.js.map
