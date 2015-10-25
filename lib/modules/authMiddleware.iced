log = require '../logging/log.iced'

# Json web token authentication
jwt = require 'jsonwebtoken'
secret = 'secretData'

# Export express middleware function to authenticate 'user'
module.exports = authMiddleware = (req, res, next)->
  log.debug "Authenticating Request"
  # support token in headers, body, or query
  token = req.cookies.token ? req.headers['x-access-token'] ? req.body.token ? req.query.token

  unless token? # unless the token exists, fail authentication
    log.debug("Failed auth - no token.");
    response =
      "success": false
      "message": 'No authentication token provided.'
    res.redirect 403 , 'http://localhost:5555/auth' # why doesn't this actually redirect?
    return # end the response, do not continue to next middleware


  jwt.verify token, secret, (err, decoded)->
    if err?
      log.error "Error decoding token in auth middleware:", {err}
      response =
        "success": false,
        "message": 'Failed to authenticate token.'
      res.json(response)
      return # end the response, do not continue to next middleware

    log.debug "Auth successful.", {decoded}
    req.decoded = decoded
    next()
