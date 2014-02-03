'use strict';

angular.module('vivoconfApp')
.controller 'ConferenceCtrl', ($scope, Conference, $routeParams, $rootScope)->
    conference_id = $routeParams.id
    $scope.conference = Conference.get {id: conference_id}
    $rootScope.conference_id = conference_id