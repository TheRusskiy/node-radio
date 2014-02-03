"use strict"
mongoose = require("mongoose")
Conference = mongoose.model('Message')

exports.index = (req, res, next) ->
  Conference.find {}, (err, all)->
    if (err) then return next(new Error('Failed to load User'));
    if all
      res.json all
    else
      res.send(404, 'NOTHING_FOUND');


exports.show = (req, res, next) ->
  userId = req.params.id
  Conference.findById userId, (err, all)->
    if (err) then return next(new Error('Failed to load User'));
    if all
      res.json all
    else
      res.send(404, 'NOTHING_FOUND');

exports.delete = (req, res, next) ->
  userId = req.params.id
#  Conference.remove {_id: userId}, (err)->
#    res.send(404, err);
  Conference.findOne {}, (conf)->
    null


exports.create = (req, res, next) ->
  conf = new Conference(req.body)
  conf._creator = req.user
  conf.save (err) ->
    if err
      err.errors.email.type = "The specified email address is already in use."  if err.errors.email.type is "Value is not unique."
      return res.json(400, err)
    req.logIn conf, (err) ->
      return next(err)  if err
      res.json req.user.userInfo


exports.update = (req, res, next) ->
  null


exports.uploadSlides = (req, res, next) ->
  console.log 'uploading!'

