"use strict"


natural = require('natural')
nounInflector = new natural.NounInflector();
mongoose = require("mongoose")

#
getResource = (req)->
  splited = req.path.split('/')
  if (splited[0]=='') then splited.splice(0,1)
  if (splited[0]=='api') then splited.splice(0,1)
  resources = splited[0]
  resource = nounInflector.singularize(resources)
  resource = resource.charAt(0).toUpperCase() + resource.slice(1); # Capitalize
  mongoose.model(resource)

auth = (role_middleware_hash)->
  return (req, res, next)->
    # transform to [{role: function}, {another_role: true}] format:
    role_middleware_array = for key, value of role_middleware_hash then obj={}; obj[key]=value; obj
    if not req.user? then res.send(403); return; # no user == no access
    nextFn = (allowed)->
      if allowed is true # previous call allowed access
        next()
      else if role_middleware_array.length is 0 or allowed is false # all middleware behind, still no explicit access
        res.send(403)
      else
        [[role,fn]]=for key, value of role_middleware_array.splice(0,1)[0] then [key, value];
        if req.user.role is role
          if typeof(fn) is "function" # User with this role can do stuff only if provided function allows it
            fn.call()(req, res, nextFn)
          else  # User with this role is allowed without any conditions
            nextFn(fn)
        else
          nextFn() # this middleware says nothing, try next
    nextFn() # start recursion

auth.checkOwner = ()-> (req, res, next)->
  getResource(req).findOne {_id: req.params.id}, (err, conf)->
    if conf._creator.toString() is req.user._id.toString()
      next(true)
    else
      res.send(403)



###
Custom middleware used by the application
###
module.exports = auth
