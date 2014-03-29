'use strict';

angular.module('radioApp')
  .controller 'ChatCtrl', ($scope, Socket, $rootScope, messageFilter, Smiles)->
    $scope.showSmiles = false
    $scope.currentMessage = ""
    $scope.smiles = Smiles
    $scope.addSmile = (smile)->
      $scope.currentMessage+=':'+smile.shortcut+':'
    $scope.toggleSmiles = ()->
      $scope.showSmiles = !$scope.showSmiles
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

    parseMessage = (text)->
      w_ct_smiley = /(?:(?::)([A-Za-z0-9]{2,})(?::))/g;
      makeSmileLink = (match0, match1)->
        for smile in Smiles
          if match1 is smile.shortcut
            return "<img src='#{smile.path}'>"
        return "no-img"
      text = text.replace(w_ct_smiley, makeSmileLink)

    $scope.submitMessage = (form)->
      if form.$valid
        Socket($scope).emit 'create_message', {text: parseMessage($scope.currentMessage)}
        $scope.currentMessage = ""
