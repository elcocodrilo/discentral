$ = require 'jquery'
request = require 'superagent' #ajax with less suck

chat = require './chat.iced'; chat()

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
  <div class="fiatbox">
    <h3>
    fi·at mon·ey
    </h3>

    <p>
      <i> noun ~</i>
        inconvertible paper money made legal tender by a government decree.
    </p>
  </div>
    """
,
# mouse leave
  ()->
    $(@).empty()
    $(@).append 'fiat money.'


$('.premise').hover ()->
# mouse enter
  $(@).append """
  <div class="premisebox">
    <h3>
      prem·ise
    </h3>

    <p>
      <i> noun ~</i>
        A premise is a statement that will induce or justify a conclusion. In other words: a premise is an assumption that something is true.
    </p>
  </div>
    """
,
# mouse leave
  ()->
    $(@).empty()
    $(@).append 'Premise:'
