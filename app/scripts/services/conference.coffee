#"use strict"
#angular.module("radioApp").factory "Conference", ($resource) ->
#  $resource "/api/conferences/:id",
#    {id: "@id"},
#    update:
#      method: "PUT"
#      params: {}
#    query:
#      method:'GET'
#      isArray:true