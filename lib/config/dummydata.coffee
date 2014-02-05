"use strict"
mongoose = require("mongoose")
User = mongoose.model("User")
#Conference = mongoose.model("Conference")
#Thing = mongoose.model("Thing")
#
####
#Populate database with sample application data
####
#
##Clear old things, then add things in
#Thing.find({}).remove ->
#  Thing.create
#    name: "HTML5 Boilerplate"
#    info: "HTML5 Boilerplate is a professional front-end template for building fast, robust, and adaptable web apps or sites."
#    awesomeness: 10
#  ,
#    name: "AngularJS"
#    info: "AngularJS is a toolset for building the framework most suited to your application development."
#    awesomeness: 10
#  ,
#    name: "Karma"
#    info: "Spectacular Test Runner for JavaScript."
#    awesomeness: 10
#  ,
#    name: "Express"
#    info: "Flexible and minimalist web application framework for node.js."
#    awesomeness: 10
#  ,
#    name: "MongoDB + Mongoose"
#    info: "An excellent document database. Combined with Mongoose to simplify adding validation and business logic."
#    awesomeness: 10
#  , ->
#    console.log "finished populating things"



#createDummyConference = (_creator)->
#  Conference.find({}).remove ->
#    conf = new Conference
#      _creator: _creator._id
#      name: "BestConfEvah"
#      youtube_url: "some_url"
#      messages: [
#        author: "Author3"
#        text: "text"
#        icon: "/images/anonymous.png"
#      ,
#        author: "Author4"
#        text: "text2"
#        icon: "/images/anonymous.png"
#      ]
#    conf.save (err)->
#      console.log "finished populating conferences"
#
#
#
## Clear old users, then add a default user
#User.find({}).remove ->
#  dummyUser = new User
#    provider: "local"
#    name: "Test User"
#    email: "test@test.com"
#    password: "test"
#  dummyUser.save (err)->
#    console.log "finished populating users"
#    createDummyConference(dummyUser)
