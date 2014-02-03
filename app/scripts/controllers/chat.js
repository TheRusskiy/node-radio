(function() {
  'use strict';
  angular.module('vivoconfApp').controller('ChatCtrl', function($scope, Socket, $rootScope) {
    var readableDate, room;
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
    room = 'main';
    Socket($scope).emit('subscribe', {
      room: room
    });
    $scope.messages = [];
    Socket($scope).on('message_history', function(messages) {
      var msg, _i, _len;
      for (_i = 0, _len = messages.length; _i < _len; _i++) {
        msg = messages[_i];
        msg.readableDate = readableDate(msg.date);
      }
      return $scope.messages = messages;
    });
    Socket($scope).on('message', function(msg) {
      msg.readableDate = readableDate(msg.date);
      if (msg.avatar_url == null) {
        msg.avatar_url = '/images/anonymous.png';
      }
      return $scope.messages.push(msg);
    });
    return $scope.submitMessage = function(text) {
      return Socket($scope).emit('message', {
        text: text,
        room: room
      });
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/controllers/chat.js.map
