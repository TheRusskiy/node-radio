"use strict"
mongoose = require("mongoose")
User = mongoose.model("User")
passport = require("passport")

###
Create user
###
exports.create = (req, res, next) ->
  newUser = new User(req.body)
  newUser.provider = "local"
  newUser.save (err) ->
    if err
      # Manually provide our own message for 'unique' validation errors, can't do it from schema
      err.errors.nickname.type = "The specified nickname is already in use."  if err.errors.nickname.type is "Value is not unique."
      return res.json(400, err)
    req.logIn newUser, (err) ->
      return next(err)  if err
      res.json req.user.userInfo




###
Get profile of specified user
###
exports.show = (req, res, next) ->
  userId = req.params.id
  User.findById userId, "-salt -hashedPassword", (err, user) ->
    return next(new Error("Failed to load User"))  if err
    if user
      res.send profile: user.profile
    else
      res.send 404, "USER_NOT_FOUND"



###
Change password
###
exports.changePassword = (req, res, next) ->
  userId = req.user._id
  oldPass = String(req.body.oldPassword)
  newPass = String(req.body.newPassword)
  User.findById userId, "-salt -hashedPassword", (err, user) ->
    if user.authenticate(oldPass)
      user.password = newPass
      user.save (err) ->
        if err
          res.send 500, err
        else
          res.send 200

    else
      res.send 400



###
Get current user
###
exports.me = (req, res) ->

  #  res.json(req.user || null);
  unless req.user
    res.send 404, "USER_NOT_FOUND"
    return
  userId = req.user._id
  User.findById userId, "-salt -hashedPassword", (err, user) ->
    return next(new Error("Failed to load User"))  if err
    if user
      res.json user
      res.cookie "currentUser", JSON.stringify(user)
    else
      res.send 404, "USER_NOT_FOUND"
