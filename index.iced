# Application utilities
log = require './lib/logging/log.iced'
config = require 'config'

# Webserver objects
express = require 'express'
app = express()
http = require('http').createServer(app)
io = require('socket.io')(http)

io.on 'connection', ()->
  log.info 'Connected!'

# express middleware modules
bodyParser  = require 'body-parser'
cookieParser = require 'cookie-parser'
favicon = require 'serve-favicon'
responseTime = require 'response-time'
serveStatic = require 'serve-static'

# custom express middleware modules
authMiddleware = require './lib/modules/authMiddleware.iced'


# route controllers
loginController = require './lib/controllers/loginCtrl.iced'   # Create token
chatController = require './lib/controllers/chatCtrl.iced'

# html pages
index = require './lib/frontend/index.iced'

# database
mongo = require 'mongodb'
mongo.connect (config.get 'db'), (database_error,db)->
  return log.error 'Database error', {database_error} if database_error
# Once we connect to the database we can configure the application:
# with database connections to collections:
  membersdb = db.collection 'members' # for authentication
  chatdb = db.collection 'chat'     # forum

# Configure the express application; order is VERY important;
  app.use favicon(__dirname + '/lib/frontend/public/favicon.ico')
  app.use serveStatic(__dirname+'/lib/frontend/public') # serve static, css, js files from here
  app.use cookieParser() # populate req.cookies

# performance monitor, request logger
  app.use responseTime (req, res, time)->
      log.req "Response Time Log",
        time:time
        method:req.method
        url : req.path

# json from frontend via superagent
  app.use bodyParser.json()

# Protect with auth token
  app.use '/forum', authMiddleware

# controllers for functionality, must pass database object
  loginController  app , membersdb
  chatController app  , chatdb

# Return the frontend
  app.get '/' , (req,res)->
    res.send index()

# start
  app.listen (port=config.get 'port'), ()->
    log.info "http://localhost:#{port}"

  module.exports = app
