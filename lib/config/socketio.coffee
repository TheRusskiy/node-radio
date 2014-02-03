"use strict"
session_store = require("./session_store")
config = require("./config")
cookie = require('cookie')
connect = require("connect")
# http://howtonode.org/socket-io-auth

module.exports = (io) ->

  io.configure ->
    io.set('log level', config.socketio.log_level)

    io.set "authorization", (handshakeData, accept) ->

      # Check whether cookies were passed
      return accept("No cookie transmitted.", false) unless handshakeData.headers.cookie

      handshakeData.cookie = cookie.parse(handshakeData.headers.cookie)
      sid = connect.utils.parseSignedCookie(handshakeData.cookie['connect.sid'], config.secret);
      handshakeData.sessionID = sid

      # unchanged if something went wrong:
      if (handshakeData.cookie['connect.sid'] == sid)
        return accept('Cookie is invalid.', false);

      console.log('SID:')
      console.log(sid)

      handshakeData.getSession = (cb) ->

        # Get session from session_storage
        session_store.get sid, (err, session) ->
          if err or not session
            console.log 'Session store get error:'
            console.log err
            return accept err, false
          cb err, session

      accept null, true

