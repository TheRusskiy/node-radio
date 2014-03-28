"use strict"
mongoose = require("mongoose")
Schema = mongoose.Schema

###
Conference Schema
###
MessageSchema = new Schema(
#  _author : { type: Schema.ObjectId, ref: 'User' }
  author_id: String
  nickname: String
  text: String
  role: String
  type: { type: String, 'default': "message"}
  avatar_url: { type: String }
  date: { type: Date, 'default': Date.now }
)

mongoose.model('Message', MessageSchema);
