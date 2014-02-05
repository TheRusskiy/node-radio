"use strict"
mongoose = require("mongoose")
Message = mongoose.model("Message")
crypto = require('crypto');
hash = (text)->crypto.createHash('md5').update(text).digest("hex")
gravatar = (nickname)->
  if nickname?
    "http://www.gravatar.com/avatar/#{hash(nickname)}?d=wavatar"
  else
    "http://www.gravatar.com/avatar?d=blank"

removeFromArray = (arr, item) ->
  i = arr.length
  while i--
    arr.splice i, 1  if arr[i] is item

module.exports = (app, io) ->
  user_list = []
  io.sockets.on "connection", (socket) ->
    socket.on 'subscribe', (data)->
      socket.handshake.getSession (err, session) ->
        if session.passport? and session.passport.user?
          newUser = session.passport.user
          newUser.avatar_url = newUser.avatar_url || gravatar(newUser.nickname)
        else
          newUser = {
            nickname: socket.handshake.nickname
            avatar_url : gravatar(socket.handshake.nickname)
            role: 'guest'
          }
          socket.emit 'guest_nickname', socket.handshake.nickname
        newUser.socket_id = socket.id
        for user in user_list
          if user?.nickname is newUser?.nickname
            removeFromArray user_list, user
        user_list.push newUser
        io.sockets.emit('user_list', user_list)
        Message.find({}).sort({'date': -1}).limit(100).exec (err, messages)->
          pojos = []
          for msg in messages
            pojos.unshift msg.toObject()
          socket.emit 'message_history', pojos
    socket.on "create_message", (data) ->
      socket.handshake.getSession (err, session) ->
        msg = new Message()
        msg.text = data.text
        if session.passport? and session.passport.user?
          user = session.passport.user
          msg.author_id = user._id
          msg.nickname = user.nickname
          msg.avatar_url = user.avatar_url || gravatar(user.nickname)
        else
          msg.author_id = null
          msg.nickname = socket.handshake.nickname
          msg.avatar_url?=gravatar(msg.nickname)
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
    socket.on "nickname_changed", (data) ->
      socket.handshake.getSession (err, session) ->
        msg = new Message()
        msg.text = "#{data.oldNickname} сменил имя на #{data.newNickname}"
        msg.author_id = null
        msg.nickname = "System"
        msg.avatar_url = gravatar(null)
        msg.save (err)->
          if err then console.log('Error saving message: '+err.toString())
          io.sockets.emit('message_created', msg.toObject())


    socket.on 'disconnect', ()->
      for user in user_list
        if user.socket_id is socket.id
          removeFromArray user_list, user
          io.sockets.emit('user_list', user_list)
          return