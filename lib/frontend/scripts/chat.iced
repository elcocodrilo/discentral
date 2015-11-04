module.exports = ()->
  $ = require 'jquery' # to insert to dom
  request = require 'superagent' # to internet

  insertMessage = (message)->
    $('.chatbox').prepend message

###
  setInterval ()->
    request
      .get '/chat'
      .end (err,response)->
        insertMessage response.text
  , 7777
###
