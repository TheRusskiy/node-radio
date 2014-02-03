"use strict"
module.exports =
  env: "production"
  host: "vivoconf.herokuapp.com"
  socketio:
    log_level: 1

  mongo:
    uri: process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or "mongodb://localhost/fullstack"