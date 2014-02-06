"use strict"
mongoose = require("mongoose")
passport = require("passport")
util = require('util')

###
Logout
###
exports.logout = (req, res) ->
  req.logout()
  res.send 200


###
Login
###
exports.login = (req, res, next) ->
  passport.authenticate("local", (err, user, info) ->
    error = err or info
    if err then console.log req.body; console.log error
    return res.json(401, error)  if error
    req.logIn user, (err) ->
      return res.send(err)  if err
      res.json req.user.userInfo

  ) req, res, next

exports.vkAuth = (req, res, next) ->
  passport.authenticate("vkontakte")(req, res, next)
# The request will be redirected to vk.com for authentication, so
# this function will not be called.
exports.fbAuth = (req, res, next) ->
  passport.authenticate("facebook")(req, res, next)
# The request will be redirected to vk.com for authentication, so
# this function will not be called.


# The request will be redirected to vk.com for authentication, so
# this function will not be called.
exports.oauthCallback = (req, res, next) ->
  passport.authenticate(
    req.query.strategy,
    {failureRedirect: "/login"},
    (err, user)->
      req.user=user
      req.logIn user, (err) ->
        return res.send(err) if err
      return next()
  )(req, res, next)

exports.closeWindow = (req, res, next) ->
#  res.cookie('currentUser', JSON.stringify(req.user));
  res.render(
    'partials/oauth_callback',
    {
      userData: req.user
    }
  )
