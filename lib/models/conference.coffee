"use strict"
mongoose = require("mongoose")
Schema = mongoose.Schema

###
Conference Schema
###
ConferenceSchema = new Schema(
  _creator : { type: Schema.ObjectId, ref: 'User' }
  user_id: String
  name: String
  youtube_url: String
  slide_urls: []
  slides_source: String
  messages: []
)

mongoose.model('Conference', ConferenceSchema);
