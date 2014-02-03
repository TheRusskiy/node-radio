'use strict';

angular.module('vivoconfApp')
  .controller 'ChatCtrl', ($scope, Socket, $rootScope)->
    readableDate = (date)->
      date = new Date(date)
      checkTime = (i) ->
        i = "0" + i  if i < 10
        i
      h = date.getHours()
      m = date.getMinutes()
      s = date.getSeconds()
      m = checkTime(m)
      s = checkTime(s)
      h + ":" + m + ":" + s

    room = 'main' # doesn't really matter
    Socket($scope).emit 'subscribe', {room}
    $scope.messages = [ ]
    Socket($scope).on 'message_history', (messages)->
      for msg in messages
        msg.readableDate = readableDate(msg.date)
      $scope.messages = messages
    Socket($scope).on 'message', (msg)->
      msg.readableDate = readableDate(msg.date)
      msg.avatar_url?='/images/anonymous.png'
      $scope.messages.push msg

#    Chat.onMessage (msg)->
#
    $scope.submitMessage = (text)->
      Socket($scope).emit 'message', {text, room}
