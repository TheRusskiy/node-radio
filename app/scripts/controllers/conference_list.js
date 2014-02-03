(function() {
  'use strict';
  angular.module('vivoconfApp').controller('ConferenceListCtrl', function($scope, Conference) {
    return $scope.conferenceList = Conference.query(function(data) {
      return null;
    });
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/conference_list.js.map
