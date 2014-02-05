'use strict';

var express = require('express'),
    path = require('path'),
    fs = require('fs'),
    mongoose = require('mongoose'),
    http = require('http');

var socketio = require('socket.io');

require('coffee-script');

/**
 * Main application file
 */

// Default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

// Application Config
var config = require('./lib/config/config');

// Connect to database
mongoose.connect(config.mongo.uri, config.mongo.options);
var db = mongoose.connection;
db.on('connecting', function() {
    console.log('connecting to MongoDB...');
});

db.on('error', function(error) {
    console.error('Error in MongoDb connection: ' + error);
    mongoose.disconnect();
});
db.on('connected', function() {
    console.log('MongoDB connected!');
});
db.once('open', function() {
    console.log('MongoDB connection opened!');
});
db.on('reconnected', function () {
    console.log('MongoDB reconnected!');
});
db.on('disconnected', function() {
    console.log('MongoDB disconnected!');
    mongoose.connect(config.mongo.uri, config.mongo.options);
});

// Bootstrap models
var modelsPath = path.join(__dirname, 'lib/models');
fs.readdirSync(modelsPath).forEach(function (file) {
  require(modelsPath + '/' + file);
});

// Populate empty DB with sample data
require('./lib/config/dummydata');
  
// Passport Configuration
require('./lib/config/passport')();

var app = express();

// Express settings
require('./lib/config/express')(app);

// Routing
require('./lib/routes')(app);

// Start server
//app.listen(config.port, function () {
//  console.log('Express server listening on port %d in %s mode', config.port, app.get('env'));
//});
var server = http.createServer(app).listen(config.port, function(){
    console.log('Express server listening on port %d in %s mode', config.port, app.get('env'));
});
var io = socketio.listen(server);

// SocketIO settings
require('./lib/config/socketio')(io);

// Chat
require('./lib/chat')(app, io);


if (process.env.NODE_ENV == 'development'){
    setTimeout(function() {
      require('fs').writeFileSync('.grunt/rebooted', 'rebooted');
    }, 100);
}
// Expose app
//noinspection JSUnresolvedVariable,JSUnresolvedVariable
exports = module.exports = app;

