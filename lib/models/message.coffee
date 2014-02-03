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
  avatar_url: { type: String, default: "http://www.gravatar.com/avatar?d=mm" }
  date: { type: Date, default: Date.now }
)

mongoose.model('Message', MessageSchema);
