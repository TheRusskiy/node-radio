"use strict"

###
Scroll keep scroll at bottom
###
angular.module("radioApp").filter "message", ($sce, $sanitize)->
  return_full_smile = (sm)->
    "<img src='./stuff/smileys/" + sm.slice(1, -1) + ".gif'>";
  w_ct_smiley = /(:[A-Za-z0-9]{2,}:)/g;
  w_ct_smileys_group = /((?::[A-Za-z0-9]{2,}:\s{0,}){3,})/g;
  nickname_regex = /(?:(?:\s@|^@))(\w+)/g # @nickname
  return (input)->
    input = input.replace(nickname_regex, "<b>$1</b>")
    input