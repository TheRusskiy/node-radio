(function() {
  'use strict';
  angular.module('vivoconfApp').controller('ChatCtrl', function($scope, Socket, $rootScope) {
    var room;
    room = $rootScope.conference_id;
    Socket($scope).emit('subscribe', {
      room: room
    });
    $scope.messages = [];
    Socket($scope).on('conference_info', function(conf) {
      return $scope.messages = conf.messages;
    });
    Socket($scope).on('message', function(data) {
      if (data.icon == null) {
        data.icon = '/images/anonymous.png';
      }
      return $scope.messages.push(data);
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
