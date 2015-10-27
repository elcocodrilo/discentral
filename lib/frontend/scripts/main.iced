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


# hover animation
$('.fiat').hover ()->
# mouse enter
  $(@).append """
    <h6>
      A formal authorization or proposition; a decree: adopting a legislative review program, rather than trying to regulate by fiat
    </h6>
""",
# mouse leave
  ()->
    $(@).empty()
    $(@).append 'fiat.'
