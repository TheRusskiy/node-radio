"use strict"

###
Scroll keep scroll at bottom
###
angular.module("radioApp").filter "message", ($sce, $sanitize)->
  nickname_regex = /(?:(?:\s@|^@))(\w+)/g # @nickname
  return (input)->
    input = input.replace(nickname_regex, "<b>$1</b>")
    input