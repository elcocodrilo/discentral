ck = require 'coffeekup' #because coffeescript is html:
fs = require 'fs'
bg = require './svgs/bg'

template = ()->
  li message

module.exports = (message)->
  ck.render template, locals:{message}
