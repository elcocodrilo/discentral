# Application utilities
config = require 'config'

# express application
express = require 'express'
app = express()

# express middleware modules
bodyParser  = require 'body-parser'
cookieParser = require 'cookie-parser'
favicon = require 'serve-favicon'
responseTime = require 'response-time'
serveStatic = require 'serve-static'

# custom express middleware modules
authMiddleware = require './lib/modules/authMiddleware.iced'

# mongo logs
log = require './lib/logging/log.iced'

# route controllers
loginController = require './lib/controllers/loginCtrl.iced'   # Create token
forumController = require './lib/controllers/forumCtrl.iced'

# html pages
index = require './lib/frontend/index.iced'

# database
mongo = require 'mongodb'
mongo.connect (config.get 'db'), (database_error,db)->
  return log.error 'Database error', {database_error} if database_error
# Once we connect to the database we can configure the application:
# with database connections to collections:
  membersdb = db.collection 'members' # for authentication
  forumdb = db.collection 'forum'     # forum manager

# Configure the express application; order is VERY important;
  app.use favicon(__dirname + '/lib/frontend/public/favicon.ico')
  app.use serveStatic(__dirname+'/lib/frontend/public') # serve static, css, js files from here
  app.use cookieParser() # populate req.cookies

# performance monitor, request logger
  app.use responseTime (req, res, time)->
      log.req "Response Time Log",
        time:time
        method:req.method
        headers:req.headers
        url : req.path
        body : req.body

# json from frontend via superagent
  app.use bodyParser.json()

# Protect with auth token
  app.use '/forum', authMiddleware

# controllers for functionality, must pass database object
  loginController  app , membersdb
  forumController app  , forumdb

# Return the frontend
  app.get '/' , (req,res)->
    res.send index()

# start
  app.listen (port=config.get 'port'), ()->
    log.info "http://localhost:#{port}"

  module.exports = app
