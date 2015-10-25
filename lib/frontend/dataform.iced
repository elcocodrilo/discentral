ck = require 'coffeekup' #because coffeescript is html:
fs = require 'fs'
bg = require './svgs/bg'

#TODO make the href to bundles dynamic

htmlTemplate = ()->
# using http://getskeleton.com/
  link
    rel:"stylesheet"
    type:"text/css"
    href:"http://localhost:5555/bundle.css"
  body class:'container' , ->
    div id:'background', ->
      text bg
    form class:'u-full-width', id:'mainform',->
      h1 title
      for field, dataType of dataRequestDoc
        #span ->
          #text icon
        label field.split('_').join(' ')
        switch dataType
            when 'text'       then input type:'text',name:field, class:'u-full-width'
            when 'email'      then input type:'email',name:field, class:'u-full-width'
            when 'password'   then input type:'password',name:field, class:'u-full-width'
            when '$'          then input type:'number',step:"0.01",name:field, class:'u-full-width'
            when 'int'        then input type:'number',step:1,name:field, class:'u-full-width'
            when 'textbox'    then textarea cols:40, rows:5, name:field, class:'u-full-width'
            when 'date'       then input type:'date', name:field, class:'u-full-width'
            when 'float'      then input type:'number',name:field, class:'u-full-width'
            when 'boolean'    then input type:'checkbox',name:field, class:'u-full-width'
            when 'range'      then input type:'range',name:field, class:'u-full-width'
            when 'list'       then select ".#{field}.u-full-width", ->
              option ' '
      button {class:'u-full-width',type:'submit'}, 'submit'
  script src:"http://localhost:5555/bundle.js"

# render html with:
#     title : string
#     dataRequestDoc: {'Label_of_the_input_underscores_become_spaces': dataType from above, ...}
module.exports = (title, dataRequestDoc)->
  ck.render htmlTemplate, locals:{title,dataRequestDoc,bg}
