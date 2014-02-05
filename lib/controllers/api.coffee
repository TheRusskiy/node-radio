"use strict"
mongoose = require("mongoose")
#Thing = mongoose.model("Thing")

###
Get awesome things
###
#exports.awesomeThings = (req, res) ->
#  Thing.find (err, things) ->
#    unless err
#      res.json things
#    else
#      res.send err

exports.uploadSlides = (req, res) ->
  console.log('!!!!!!!!!!!!!!!!!!!!!!')
  console.log(req.body)
  console.log(req.query)
  res.send('Some shit from server')
