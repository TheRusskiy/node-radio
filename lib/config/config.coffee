"use strict"
_ = require("lodash")

###
Load environment configuration
###
module.exports = _.extend(require("./env/all.coffee"), require("./env/" + process.env.NODE_ENV + ".coffee") or {})