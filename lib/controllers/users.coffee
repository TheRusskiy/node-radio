"use strict"
mongoose = require("mongoose")
User = mongoose.model("User")
passport = require("passport")

###
Create user
###
exports.create = (req, res, next) ->
  newUser = new User(req.body)
  console.log req.body
  newUser.provider = "local"
  newUser.save (err) ->
    if err
      if err then console.log err
      # Manually provide our own message for 'unique' validation errors, can't do it from schema
      if err.errors.nickname.type is "Value is not unique."
        err.errors.nickname.type = "The specified nickname is already in use."
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
Update profile
###
exports.updateProfile = (req, res, next) ->
  userId = req.user._id
  oldPass = String(req.body.oldPassword)
  newPass = String(req.body.newPassword)
  User.findById userId, "", (err, user) ->
    console.log "old: #{oldPass}, new: #{newPass}"
    unless oldPass is "undefined" or user.authenticate(oldPass)
      console.log 'Unsuccessfull attempt to change password'
      err =
        errors:
          password:
            type: "Old password is incorrect"
      res.json 400, err
      return
    user.password = newPass if oldPass isnt "undefined"
    user.nickname = req.body.nickname
    user.save (err) ->
      if err
        if err.errors.nickname.type is "Value is not unique."
          err.errors.nickname.type = "The specified nickname is already in use."
        res.json 500, err
      else
        req.logIn user, (err) ->
          return next(err) if err
          res.json 200




###
Get current user
###
exports.me = (req, res) ->

  #  res.json(req.user || null);
  unless req.user
    res.send 204
    return
  userId = req.user._id
  User.findById userId, "-salt -hashedPassword", (err, user) ->
    return next(new Error("Failed to load User"))  if err
    if user
      res.json user
#      res.cookie "currentUser", JSON.stringify(user)
    else
      res.send 404, "USER_NOT_FOUND"
