"use strict"
express = require("express")
path = require("path")
config = require("./config")
passport = require("passport")
session_store = require("./session_store")
connect = require('connect')

#var redis = require("redis"),
#    client = redis.createClient();
#var RedisStore = require('connect-redis')(express);

###
Express configuration
###
module.exports = (app) ->
  app.configure "development", ->
    app.use require("connect-livereload")()

    # Disable caching of scripts for easier testing
    app.use noCache = (req, res, next) ->
      if req.url.indexOf("/scripts/") is 0
        res.header "Cache-Control", "no-cache, no-store, must-revalidate"
        res.header "Pragma", "no-cache"
        res.header "Expires", 0
      next()

    app.use express.static(path.join(config.root, ".tmp"))
    app.use express.static(path.join(config.root, "app"))
    app.use express.errorHandler()
    app.set "views", config.root + "/app/views"

  app.configure "production", ->
    app.use express.favicon(path.join(config.root, "public", "favicon.ico"))
    app.use express.static(path.join(config.root, "public"))
    app.set "views", config.root + "/views"

  app.configure ->
    app.engine "html", require("ejs").renderFile
    app.set "view engine", "html"
    app.use express.logger("dev")
#    app.use(connect.bodyParser());
    app.use(connect.urlencoded())
    app.use(connect.json())
    app.use express.methodOverride()
    app.use express.cookieParser()

    # Persist sessions with mongoStore
    app.use express.session(
      secret: config.secret
      store: session_store
      key: 'connect.sid'
    )

    #    Persist sessions with redisStore
    #    var options = {
    #        client: client,
    #        host: 'localhost',
    #        port: '6379'
    #    };
    #    app.use(express.session({ store: new RedisStore(options), secret: 'keyboard cat' }))

    #use passport session
    app.use passport.initialize()
    app.use passport.session()

    # Router needs to be last
    app.use app.router
