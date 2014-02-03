'use strict';

angular.module('vivoconfApp')
  .controller 'SlideshareCtrl', ($scope, Socket, $http, $rootScope)->
    $scope.errors = {}
    $scope.user = {}
    $scope.import = (form)->
      $scope.submitted = true
      if form.$valid
        console.log 'Sending: '+$scope.slidesUrl
        $http.post("/api/conferences/#{$rootScope.conference_id}/slides", {slides_url: $scope.slidesUrl})
        .then( (response)->
            alert(JSON.stringify(response))
        )
        .catch( (err)->
            alert(JSON.stringify(err))
        );