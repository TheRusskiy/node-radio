"use strict"
mongoose = require("mongoose")
User = mongoose.model("User")
passport = require("passport")
LocalStrategy = require("passport-local").Strategy
VKontakteStrategy = require("passport-vkontakte").Strategy
FacebookStrategy = require("passport-facebook").Strategy

###
Passport configuration
###
module.exports = ()->
  config = require('./config');
  passport.serializeUser (user, done) ->
    done null, user

  passport.deserializeUser (user, done) ->
    User.findOne
      _id: user._id
    , "-salt -hashedPassword", (err, user) -> # don't ever give out the password or salt
      done err, user



  # add other strategies for more authentication flexibility
  passport.use new LocalStrategy(
    usernameField: "email"
    passwordField: "password" # this is the virtual field on the model
  , (email, password, done) ->
    User.findOne
      email: email
    , (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "This email is not registered."
        )
      unless user.authenticate(password)
        return done(null, false,
          message: "This password is not correct."
        )
      done null, user

  )
  passport.use new VKontakteStrategy(
    {
      clientID: 4008540 # VK.com docs call it 'API ID'
      clientSecret: "aeyNqi6KrcHq88LH5zUJ"
      callbackURL: "http://#{config.host}:#{config.port}/auth/oauth/callback?strategy=vkontakte"
    }
  , (accessToken, refreshToken, profile, done) ->
    User.findOne('vkontakte.id': profile.id)
    .select("first_name last_name vkontakte.id email pic_small")
    .exec (err, user) ->
      unless user?
          user = new User {
            first_name: profile._json.first_name
            last_name: profile._json.last_name
            pic_small: profile._json.photo
            vkontakte: profile
            providers: ['vkontakte']
          }
          user.save (err)->
            done(err, user)
        else
          done(err, user)
  )

  passport.use new FacebookStrategy(
    {
      clientID: 239383119560229
      clientSecret: "11c8e05e27ec7de062b1293b8f077eeb"
      callbackURL: "http://#{config.host}:#{config.port}/auth/oauth/callback?strategy=facebook"
    }
  , (accessToken, refreshToken, profile, done) ->
    User.findOne('email': profile._json.email)
    .select("first_name last_name facebook.id email pic_small")
    .exec (err, user) ->
      unless user?
        user = new User {
          email: profile._json.email
          first_name: profile._json.first_name
          last_name: profile._json.last_name
          pic_small: "http://graph.facebook.com/#{profile.id}/picture"
          facebook: profile
          providers: ['facebook']
        }
        user.save (err)->
          done(err, user)
      else
        done(err, user)
  )