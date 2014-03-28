"use strict"
angular.module("radioApp").factory "Socket", ($rootScope) ->
  # io is a global object available if you included socket.io script:
  socket = io.connect()
  ###
    $scope - scope of a controller
    global - boolean indicating whether a change applies only
             to a local scope or to a $rootScope
             (in case perfomansc is an issues)
  ###
  resultObject = ($scope, global = true)->
    scopeOfChange = if global then $rootScope else $scope
    # create an array of listeners if there is none (notice '?' operator):
    $scope._listeners?= []
    # if controller's scope is destroyed then $destroy event is fired
    # on this event we should get rid of all listeners on this scope:
    $scope.$on '$destroy', (event)->
      for lis in $scope._listeners
        socket.removeListener(lis.eventName, lis.ngCallback)
      $scope._listeners.length=0

    # return familiar to us socket.io object that can listen to and emit events:
    return  {
    on: (eventName, callback) ->
      ngCallback = ()->
        args = arguments
        # trigger angular $digest cycle on selected scope:
        scopeOfChange.$apply ->
          callback.apply socket, args # apply function to original object
      # save listener to a list on current scope so we can remove it later:
      $scope._listeners.push {
        eventName
        ngCallback
      }
      # pass our own callback that wraps the one passed by a user
      socket.on eventName, ngCallback

    emit: (eventName, data, callback) ->
      socket.emit eventName, data, ->
        args = arguments
        scopeOfChange.$apply ->
          callback.apply socket, args  if callback
    }
  # sometimes I find reconnect to be usefull:
  resultObject.reconnect = ()->
    socket.socket.disconnect()
    socket.socket.connect()
  return resultObject
