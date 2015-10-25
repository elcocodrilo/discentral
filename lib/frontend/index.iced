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
    h3 'Dis-inter-mediate'
    div class:'define four columns',->
      p '1. <strike>In finance,</strike> withdrawal of funds from intermediary financial institutions, such as banks and savings and loan associations, <strike> in order to invest them directly.</strike>'
      p '2. Generally, removing the middleman or intermediary.'
    div class:"row twelve columns", ->
      div class:'define five columns', ->
        p "There are significant efficiencies to be gained through disintermediation of politicians and of bankers"
      div class:'define two columns'
      div class:'define five columns note',->
        p "In the past politicians provided a meaningful way for distant regions of our vast country to express legitimate concerns. It was essential to our democracy for distant regions to influence federal decisions."
        p "Now, the majority of representatives vote on a party line, which often caters to the <i>parties electoral interests</i> above all else. "

  script src:"http://localhost:5555/bundle.js"

# render html with:
#     title : string
#     dataRequestDoc: {'Label_of_the_input_underscores_become_spaces': dataType from above, ...}
module.exports = ()->
  x = ck.render htmlTemplate, locals:{bg}
  console.log x
  return x
