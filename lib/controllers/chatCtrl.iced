log = require '../logging/log.iced'
messageHtml = require '../frontend/messages.iced'

module.exports = transferController = (app)->
    log.info "Initializing Chat Controller"

    test = messageHtml 'testy te'
    app.get '/chat', (req,res)->
      log.warn "warning", test
      res.send  test

    # app.post '/transfer/:country/:cashout', (req,res)-> TODO
