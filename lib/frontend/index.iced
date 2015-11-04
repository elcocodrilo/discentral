ck = require 'coffeekup' #htmloffeescript:
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
    div class:"row twelve columns", ->
      div class:'define five columns', ->
        h4 "<span class='premise'>Premise:</span>"
        p "<span class='disint'><b><i>Disintermediate</b></i></span> beauracracy,  and finance."
        p 'The complex web of beauracracy can be largely replaced by automated systems.'
        p 'We must seriously explore then act on the alternatives to nineteenth century representative democracy and <span class="fiat"><b><i>fiat money.</b></i></fiat>'
      div class:'define five columns note1',->
        p "In the past politicians provided a meaningful way for distant regions of our vast country to express legitimate concerns. It was essential to our democracy for distant regions to have a way to influence federal decisions."
        p "Now, the majority of representatives vote on a party line, which often caters to the <i>parties electoral interests</i> above all else. "
      div class:'define five columns note2',->
        p "In the past government backed banks were essential for businesses across regions, borders, or oceans to engage in trusted transactions."
        p "Now our financial industry abuses it's authority to create money, and systematically - through loan creation, whether mortgage, student, credit card or soveriegn - funnels an increasing percentage of our societies wealth to the financial elites. "
      div class:"row", ->
        div class:'define four columns panel',->
          text 'test'
        div class:'define four columns panel',->
          text 'test'
        div class:'define four columns panel',->
          text 'test'
  div class:'chatbox'
  div class:'chatin', ->
    input type:'textbox',name:'speech'
  script src:"http://localhost:5555/bundle.js"

# render html with:
#     title : string
#     dataRequestDoc: {'Label_of_the_input_underscores_become_spaces': dataType from above, ...}
module.exports = ()->
  x = ck.render htmlTemplate, locals:{bg}
  return x
