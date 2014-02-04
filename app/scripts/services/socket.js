(function() {
  "use strict";
  angular.module("radioApp").service("Socket", function($rootScope) {
    var socket;
    socket = io.connect();
    return function($scope) {
      if ($scope._subscriptions == null) {
        $scope._subscriptions = [];
      }
      $scope.$on('$destroy', function(event) {
        var sub, _i, _len, _ref;
        _ref = $scope._subscriptions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          sub = _ref[_i];
          socket.removeListener(sub.eventName, sub.callback);
        }
        return $scope._subscriptions.length = 0;
      });
      return {
        on: function(eventName, cb) {
          var callback;
          callback = function() {
            var args;
            args = arguments;
            $rootScope.$apply(function() {
              return cb.apply(socket, args);
            });
            return $rootScope.$apply();
          };
          $scope._subscriptions.push({
            eventName: eventName,
            callback: callback
          });
          return socket.on(eventName, callback);
        },
        emit: function(eventName, data, callback) {
          return socket.emit(eventName, data, function() {
            var args;
            args = arguments;
            return $rootScope.$apply(function() {
              if (callback) {
                return callback.apply(socket, args);
              }
            });
          });
        }
      };
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/services/socket.js.map
