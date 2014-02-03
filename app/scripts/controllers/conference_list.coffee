'use strict';

angular.module('vivoconfApp')
.controller 'ConferenceListCtrl', ($scope, Conference)->
    $scope.conferenceList = Conference.query (data)-> null


#when("/chat",
#templateUrl: "partials/chat"
#controller: "ChatCtrl"
#).when("/slideshare",
#  templateUrl: "partials/slideshare"
#  controller: "SlideshareCtrl"