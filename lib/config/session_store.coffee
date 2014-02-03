"use strict"

config = require('./config')
express = require('express')
mongoStore = require('connect-mongo')(express);

module.exports = new mongoStore({
    url: config.mongo.uri,
    collection: 'sessions'
  })