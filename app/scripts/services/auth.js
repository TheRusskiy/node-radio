(function() {
  "use strict";
  var Auth;

  angular.module("radioApp").factory("Auth", Auth = function($location, $rootScope, Session, User, $cookieStore, $window) {
    var oauth;
    oauth = function(strategy, callback) {
      $window.open("/auth/" + strategy, "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=400, height=400");
      $window.oauth_callback = callback;
      return true;
    };
    return {
      vkLogin: function(callback) {
        return oauth('vkontakte', callback);
      },
      fbLogin: function(callback) {
        return oauth('facebook', callback);
      },
      /*
      Authenticate user
      
      @param  {Object}   user     - login info
      @param  {Function} callback - optional
      @return {Promise}
      */

      login: function(user, callback) {
        var cb;
        cb = callback || angular.noop;
        return Session.save({
          nickname: user.nickname,
          password: user.password
        }, function(user) {
          $rootScope.currentUser = user;
          return cb();
        }, function(err) {
          return cb(err);
        }).$promise;
      },
      /*
      Unauthenticate user
      
      @param  {Function} callback - optional
      @return {Promise}
      */

      logout: function(callback) {
        var cb;
        cb = callback || angular.noop;
        return Session["delete"](function() {
          $rootScope.currentUser = null;
          return cb();
        }, function(err) {
          return cb(err);
        }).$promise;
      },
      /*
      Create a new user
      
      @param  {Object}   user     - user info
      @param  {Function} callback - optional
      @return {Promise}
      */

      createUser: function(user, callback) {
        var cb;
        cb = callback || angular.noop;
        return User.save(user, function(user) {
          $rootScope.currentUser = user;
          return cb(user);
        }, function(err) {
          return cb(err);
        }).$promise;
      },
      /*
      Update profile
      
      @param  {String}   oldPassword
      @param  {String}   newPassword
      @param  {Function} callback    - optional
      @return {Promise}
      */

      updateProfile: function(user, callback) {
        var cb, changes, newPassword, nickname, oldPassword;
        oldPassword = user.oldPassword;
        newPassword = user.newPassword;
        nickname = user.nickname;
        cb = callback || angular.noop;
        changes = oldPassword != null ? {
          oldPassword: oldPassword,
          newPassword: newPassword,
          nickname: nickname
        } : {
          nickname: nickname
        };
        return User.update(changes, function(user) {}, cb(user), function(err) {
          return cb(err);
        }).$promise;
      },
      /*
      Gets all available info on authenticated user
      
      @return {Object} user
      */

      currentUser: function() {
        return User.get();
      },
      /*
      Simple check to see if a user is logged in
      
      @return {Boolean}
      */

      isLoggedIn: function() {
        var user;
        user = $rootScope.currentUser;
        return !!user;
      }
    };
  });

}).call(this);

//# sourceMappingURL=../../../app/scripts/services/auth.js.map
