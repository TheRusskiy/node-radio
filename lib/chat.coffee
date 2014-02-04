"use strict"
mongoose = require("mongoose")
Message = mongoose.model("Message")

removeFromArray = (arr, item) ->
  i = arr.length
  while i--
    arr.splice i, 1  if arr[i] is item

module.exports = (app, io) ->
  user_list = []
  io.sockets.on "connection", (socket) ->
    socket.on 'subscribe', (data)->
      socket.handshake.getSession (err, session) ->
        for user in user_list
          if user.socket_id is socket.id
            removeFromArray user_list, user
        if session.passport? and session.passport.user?
          user = session.passport.user
          user.socket_id = socket.id
          user_list.push user
        else
          user_list.push {
            socket_id: socket.id
            nickname: socket.handshake.randomNickname
            avatar_url : '/images/anonymous.png'
            role: 'guest'
          }
        io.sockets.emit('user_list', user_list)
        Message.find({}).sort({'date': 1}).limit(100).exec (err, messages)->
          pojos = []
          for msg in messages
            pojos.push msg.toObject()
          socket.emit 'message_history', pojos
    socket.on "create_message", (data) ->
      socket.handshake.getSession (err, session) ->
        msg = new Message()
        msg.text = data.text
        if session.passport? and session.passport.user?
          user = session.passport.user
          msg.author_id = user._id
          msg.nickname = user.nickname
          msg.avatar_url = user.avatar_url
        else
          msg.author_id = null
          msg.nickname = socket.handshake.randomNickname
          msg.avatar_url?='/images/anonymous.png'
        msg.save (err)->
          if err then console.log('Error saving message: '+err.toString())
          io.sockets.emit('message_created', msg.toObject())
#        socket.json.broadcast.send([{foo:'bar'}, {'ping': 12}]);
#        io.sockets.in('chat').json.emit('message', {})
    socket.on "delete_message", (data) ->
      socket.handshake.getSession (err, session) ->
        Message.findById data.id, (err, msg)->
          user = session.passport.user
          if user and (
            user.role is 'admin' or (
              msg.author_id and user._id.toString() is msg.author_id.toString()
            )
          )
            msg.remove (err)->
              if not err then io.sockets.emit('message_deleted', {_id: msg._id})
          else
            console.log 'access violation'


    socket.on 'disconnect', ()->
      for user in user_list
        if user.socket_id is socket.id
          removeFromArray user_list, user
          io.sockets.emit('user_list', user_list)
          return