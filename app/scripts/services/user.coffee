"use strict"
angular.module("vivoconfApp").factory "User", ($resource) ->
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
