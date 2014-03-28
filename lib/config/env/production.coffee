"use strict"
module.exports =
  env: "production"
  host: "151.248.116.18"
  socketio:
    log_level: 1

  mongo:
    uri: process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or "mongodb://localhost/radio"