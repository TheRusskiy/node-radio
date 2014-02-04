"use strict"
angular.module("radioApp").service "Socket", ($rootScope) ->
  socket = io.connect()
  io.currSocket = socket.socket
  returnValue = ($scope)->
    $scope._subscriptions?= []
    $scope.$on '$destroy', (event)->
      for sub in $scope._subscriptions
        socket.removeListener(sub.eventName, sub.callback)
      $scope._subscriptions.length=0

    return  {
      on: (eventName, cb) ->
        callback = ->
          args = arguments
          $rootScope.$apply ->
            cb.apply socket, args
          $rootScope.$apply()
        $scope._subscriptions.push {
          eventName
          callback
        }
        socket.on eventName, callback

      emit: (eventName, data, callback) ->
        socket.emit eventName, data, ->
          args = arguments
          $rootScope.$apply ->
            callback.apply socket, args  if callback
    }
  returnValue.reconnect = ()->
    io.currSocket.disconnect()
    io.currSocket.connect()
  return returnValue


