"use strict"
mongoose = require("mongoose")
Message = mongoose.model("Message")

module.exports = (app, io) ->
  io.sockets.on "connection", (socket) ->
    socket.on 'subscribe', (data)->
      socket.emit('user_list', [])
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
          msg.nickname = user.first_name+" "+user.last_name
          msg.avatar_url = user.pic_small
        else
          msg.author_id = null
          msg.nickname = "guest"
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
          console.log user
          console.log user.role is 'admin'
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
      # nothing