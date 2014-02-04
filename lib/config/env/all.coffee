"use strict"
path = require("path")
rootPath = path.normalize(__dirname + "/../../..")
module.exports =
  root: rootPath
  secret: "ghkjfjgfkdiyuasjnhbjchiwuqfdsjiovhcdaiopuiowuq9i03289udjmxcvlknvkjfdopsadckmvbahjtrucm"
  port: process.env.PORT or 3000
  mongo:
    options:
      db:
        safe: true
        auto_reconnect:true