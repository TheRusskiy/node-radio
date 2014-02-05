"use strict"
session_store = require("./session_store")
config = require("./config")
cookie = require('cookie')
connect = require("connect")
# http://howtonode.org/socket-io-auth
randomIntBetween = (min,max)->
  return Math.floor(Math.random()*(max-min+1)+min)

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

        if @_session? then return cb(null, @_session)
        # Get session from session_storage
        session_store.get sid, (err, session) =>
          if err or not session
            console.log 'Session store get error:'
            console.log err
            return accept err, false
          @_session = session
          cb err, session
      nickname = handshakeData.cookie.preferredNickname
      if nickname then nickname = nickname.replace(/"/g, '')
      handshakeData.nickname = nickname || "Guest"+randomIntBetween(1, 1000000).toString()

      accept null, true

