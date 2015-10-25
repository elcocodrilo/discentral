$ = require 'jquery'
request = require 'superagent' #ajax with less suck

# We listen for a submition event on the form then prevent
# the default and do our own thing.
$('form').on 'submit', (e)->
  e.preventDefault()

# Serialize html form into array then convert to standard json format
  arrayOfInputs = $(@).serializeArray()
  payload = {}; for nameValue in arrayOfInputs
    payload[nameValue.name] = nameValue.value

  request.post( window.location.pathname )
    .send payload
      .end (err,res)->
        document.cookie="token=#{res.body.token}" if res.body.token?
