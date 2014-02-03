"use strict"

###
Custom middleware used by the application
###
module.exports =
  {
  ###
  Protect routes on your api from unauthenticated access
  ###
  auth: auth = (req, res, next) ->
    return next()  if req.isAuthenticated()
    res.send 401


  ###
  Set a cookie for angular so it knows we have an http session
  ###
  setUserCookie: (req, res, next) ->
    res.cookie "user", JSON.stringify(req.user)  if req.user
    next()
  }