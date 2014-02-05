"use strict"
angular.module("radioApp").factory "Auth", ($location, $rootScope, Session, User, $cookieStore, $window, $q) ->

  # Get currentUser from cookie
#  $rootScope.currentUser = $cookieStore.get("user") or null
#  $cookieStore.remove "user"
  oauth = (strategy, callback) ->
    $window.open(
      "/auth/#{strategy}",
      "_blank",
      "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=400, height=400"
    );
    $window.oauth_callback = callback
    true # angular hates when you return window to someone

  vkLogin: (callback) -> oauth('vkontakte', callback)
  fbLogin: (callback) -> oauth('facebook', callback)


  ###
  Authenticate user
  
  @param  {Object}   user     - login info
  @param  {Function} callback - optional
  @return {Promise}
  ###
  login: (user, callback) ->
    cb = callback or angular.noop
    Session.save(
      nickname: user.nickname
      password: user.password
    , (user) ->
      $rootScope.currentUser = user
      cb()
    , (err) ->
      cb err
    ).$promise



  ###
  Unauthenticate user
  
  @param  {Function} callback - optional
  @return {Promise}
  ###

  logout: (callback)->
    cb = callback || angular.noop
    return Session.delete(
      ()->
        $rootScope.currentUser = null;
        return cb();
      ,(err)->
        return cb(err);
      ).$promise

  ###
  Create a new user
  
  @param  {Object}   user     - user info
  @param  {Function} callback - optional
  @return {Promise}
  ###
  createUser: (user, callback) ->
    cb = callback or angular.noop
    User.save(user, (user) ->
      $rootScope.currentUser = user
      cb user
    , (err) ->
      cb err
    ).$promise


  ###
  Update profile
  
  @param  {String}   oldPassword
  @param  {String}   newPassword
  @param  {Function} callback    - optional
  @return {Promise}
  ###
  updateProfile: (user, callback) ->
    oldPassword = user.oldPassword
    newPassword = user.newPassword
    nickname = user.nickname
    cb = callback or angular.noop
    changes = if oldPassword?
      {
        oldPassword: oldPassword
        newPassword: newPassword
        nickname: nickname
      }
    else
      {
        nickname: nickname
      }
    User.update( changes,
      (user) ->
      cb user
    , (err) ->
      cb err
    ).$promise


  ###
  Gets all available info on authenticated user
  
  @return {Object} user
  ###
  currentUser: ()->
    User.get()


  ###
  Simple check to see if a user is logged in
  
  @return {Boolean}
  ###
  isLoggedIn: ->
    user = $rootScope.currentUser
    !!user
