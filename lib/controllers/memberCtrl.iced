log = require '../logging/log.iced'
dataform = require '../frontend/dataform.iced'



module.exports = memberController = (app)->
    log.info "Initializing Member Controller"

    app.get '/member', (req,res)->
      res.send dataform 'Member Registration' ,
        PGP_key:'textbox'
        pseudonym:'text'

    app.post '/member', (req,res)->
      log.info req.body
      res.send "test"
