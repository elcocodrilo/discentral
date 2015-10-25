winston = require 'winston'
require('winston-mongodb').MongoDB; #expose winston.transports.MongoDB
###
Strict Logger Usage:
~ Use two arguements, the first one a string, the second an object
~ log.<level> 'message string', {meta, data, object}

Note the coffeescript notation {meta, data, object} becomes:
{ meta: 1, data: 2, object: { meta: 1, data: 2 } } if meta=1;data=2;object={meta,data}
###

# The logs are stored in mongoDB and output to the console
  # level : the level of the log data
  # timestamp : ISO timestamp
  # message : The first argument, string description
  # meta : The second argument, metadata object
log = new winston.Logger
  levels: #transports get there level and higher
    debug: 0 # debug gets all logs
    test:  1
    req:  2
    info:  3
    warn:  4
    error: 5
  colors: #mostImportantCode
    debug:'grey'
    test:'magenta'
    req: 'blue'
    info:'green'
    warn: 'yellow'
    error: 'red'
  transports: [
    new winston.transports.Console
      level: 'debug'
      handleExceptions: true
      json: false
      colorize: true
      humanReadableUnhandledException: true
    ]
  exitOnError : false

log.add winston.transports.MongoDB,
  level: 'debug'
  db:   "mongodb://localhost:27017/interbit"

module.exports = log
