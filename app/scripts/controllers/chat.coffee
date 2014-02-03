'use strict';

angular.module('vivoconfApp')
  .controller 'ChatCtrl', ($scope, Socket, $rootScope)->
    room = $rootScope.conference_id
    Socket($scope).emit 'subscribe', {room}
    $scope.messages = [ ]
    Socket($scope).on 'conference_info', (conf)->
      $scope.messages = conf.messages
    Socket($scope).on 'message', (data)->
      data.icon?='/images/anonymous.png'
      $scope.messages.push data

#    Chat.onMessage (msg)->
#
    $scope.submitMessage = (text)->
      Socket($scope).emit 'message', {text, room}
