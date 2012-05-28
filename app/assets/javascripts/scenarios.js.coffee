# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('canvas#simulation').length
    $.getJSON(location.href)
      .done (response) ->
        scenario = new Scenario(response);
        ctx = $('canvas#simulation')[0].getContext('2d')
        ctx.setFontSize(20)
        ctx.fillStyle = "Black"
        $.when(ctx.drawNodes(scenario.node))
        .then(->
          ctx
            .drawInterfaces(scenario)
            .drawMessageFlow(scenario))
    
