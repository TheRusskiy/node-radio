(function() {
  'use strict';
  angular.module('radioApp').controller('ChatCtrl', function($scope, Socket, $rootScope) {
    var readableDate, removeFromArray;
    readableDate = function(date) {
      var checkTime, h, m, s;
      date = new Date(date);
      checkTime = function(i) {
        if (i < 10) {
          i = "0" + i;
        }
        return i;
      };
      h = date.getHours();
      m = date.getMinutes();
      s = date.getSeconds();
      m = checkTime(m);
      s = checkTime(s);
      return h + ":" + m + ":" + s;
    };
    removeFromArray = function(arr, item) {
      var i, _results;
      i = arr.length;
      _results = [];
      while (i--) {
        if (arr[i] === item) {
          _results.push(arr.splice(i, 1));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    Socket($scope).emit('subscribe', {});
    $scope.messages = [];
    Socket($scope).on('message_history', function(messages) {
      var msg, _i, _len;
      for (_i = 0, _len = messages.length; _i < _len; _i++) {
        msg = messages[_i];
        msg.readableDate = readableDate(msg.date);
      }
      return $scope.messages = messages;
    });
    Socket($scope).on('user_list', function(users) {
      return $scope.users = users;
    });
    Socket($scope).on('message_created', function(msg) {
      msg.readableDate = readableDate(msg.date);
      return $scope.messages.push(msg);
    });
    Socket($scope).on('message_deleted', function(msg) {
      var m, _i, _len, _ref;
      _ref = $scope.messages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        m = _ref[_i];
        if (m._id === msg._id) {
          return removeFromArray($scope.messages, m);
        }
      }
    });
    $scope.deleteMessage = function(msg) {
      return Socket($scope).emit('delete_message', {
        id: msg._id
      });
    };
    return $scope.submitMessage = function(text) {
      return Socket($scope).emit('create_message', {
        text: text
      });
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/chat.js.map
