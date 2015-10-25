

io = require 'socket.io'
socket = io()

$ = require 'jquery' # to insert to dom
request = require 'superagent' # to internet
insertMessage = (message)->
  $('.chatbox').prepend message

socket.on 'chat message', (msg)->
  insertMessage msg

module.exports = ()->

    setInterval ()->
      socket.emit 'chat message' , $('#chatin').val()
      $('#chatin').val('')

  insertMessage 'Welcome to Decentral Chatbox'
###
  setInterval ()->
    request
      .get '/chat'
      .end (err,response)->
        insertMessage response.text
  , 7777
###
