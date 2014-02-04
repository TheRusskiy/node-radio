'use strict';

angular.module('radioApp')
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
    removeFromArray = (arr, item) ->
      i = arr.length
      while i--
        arr.splice i, 1  if arr[i] is item

    Socket($scope).emit 'subscribe', {}
    $scope.messages = [ ]

    Socket($scope).on 'message_history', (messages)->
      for msg in messages
        msg.readableDate = readableDate(msg.date)
      $scope.messages = messages

    Socket($scope).on 'user_list', (users)->
      $scope.users = users

    Socket($scope).on 'message_created', (msg)->
      msg.readableDate = readableDate(msg.date)
      $scope.messages.push msg

    Socket($scope).on 'message_deleted', (msg)->
      for m in $scope.messages
        if m._id is msg._id
          return removeFromArray($scope.messages, m)

    $scope.deleteMessage = (msg)->
      Socket($scope).emit 'delete_message', {id: msg._id}

    $scope.submitMessage = (text)->
      Socket($scope).emit 'create_message', {text}
