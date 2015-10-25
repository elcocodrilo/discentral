# utilities
log = require '../logging/log.iced'

# crypto
jwt = require 'jsonwebtoken'
secret  = 'secretData' # TODO

# html form generator
dataform = require '../frontend/dataform.iced'

module.exports = authController = (app, membersdb)->
    log.info "Initializing Auth Controller"

    # This is simple user pass authentication.
    # Password is sent over the wire, need to encrypt see frontend scripts (TODO)
    app.get '/login', (req,res)->
      res.send dataform 'Discentral, Sign In:' ,
        username:'text'
        password:'password'
        'How_is_it_going?': 'range'

    app.post '/login', (req, res)->
      name = req.body.username; pass = req.body.password;
      log.info 'Authentication Request', {name, pass}
      membersdb.findOne {name}, (err, user)->

        if err?
          log.info 'db err', {err}
          return res.json
            "success": false
            "message": "Database Error."

        unless user?
          log.info 'no user found'
          return res.json
            "success": false
            "message": "No User Found."

        unless pass == user.pass
          log.info 'wrong password'
          return res.json
            "success": false
            "message": "Password Incorrect."

        # If we get to this point we can create and return the token
        token = jwt.sign {name}, secret, expiresIn: 9999
        log.info "token created, authenticated user #{name}"
        res.json
          "success": true
          "message": 'Authentication Successful.'
          "token": token
