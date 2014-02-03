"use strict"
mongoose = require("mongoose")
Conference = mongoose.model("Conference")

module.exports = (app, io) ->
#  io.sockets.on "connection", (socket) ->
#    socket.on 'subscribe', (data)->
#      socket.join(data.room) # 'chat'
#      socket.emit('user_list', [])
#      Conference.findOne({}, (err, conf)->
#        socket.emit 'conference_info', conf
#      )
#    socket.on "message", (data) ->
#      socket.handshake.getSession (err, session) ->
#        if session.passport? and session.passport.user?
#          user = session.passport.user
#          data.author = user.first_name+" "+user.last_name
#          data.icon = user.pic_small
#        else
#          data.author = "guest"
#          data.icon?='/images/anonymous.png'
#        Conference.findOne({}, (err, conf)->
#          conf.messages.push data
#          conf.save (err)-> console.log(err)
#        )
#        io.sockets.in(data.room).emit('message', data)
##        socket.json.broadcast.send([{foo:'bar'}, {'ping': 12}]);
##        io.sockets.in('chat').json.emit('message', {})
#    socket.on 'disconnect', ()->
#      # nothing
