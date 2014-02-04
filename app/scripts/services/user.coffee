"use strict"
angular.module("radioApp").factory "User", ($resource) ->
  $resource "/api/users/:id",
    id: "@id"
  ,
    #parameters default
    update:
      method: "PUT"
      params: {}

    get:
      method: "GET"
      params:
        id: "me"
