log = require '../logging/log.iced'
dataform = require '../frontend/dataform.iced'

module.exports = transferController = (app)->
    log.info "Initializing Forum Controller"

    app.get '/forum', (req,res)->
      res.send dataform '~~~~' , post:'textbox'

    # app.post '/transfer/:country/:cashout', (req,res)-> TODO
