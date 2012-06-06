# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('canvas#simulation').length
    dashToWords = (str) ->
      (str.slice(0,1).toUpperCase() + str.slice(1)).split('_').join(' ')
    createFormFromObj = (obj, uid) ->
      $div = $('<div />', id: uid)
      for name, value of obj
        if obj.hasOwnProperty(name) and not (value instanceof Array)
          $label = $('<label />',
            for: name
            text: dashToWords(name) + ':')
          $inputField = $('<input>',
            type: 'text'
            value: value
            id: name
          )
          $inputField.change ->
            obj[$(this).attr('id')] = $(this).val()
          $div.append($label)
          $div.append($inputField)
      return $div
          
    ctx = $('canvas#simulation')[0].getContext('2d')
    scenario = null
    showEverything = ->
      ctx.setFontSize(20)
      ctx.fillStyle = "Black"
      $.when(ctx.drawNodes(scenario.node))
      .then(->
        ctx
          .drawInterfaces(scenario)
          .drawMessageFlow(scenario))
    $.getJSON(location.href)
      .done (response) ->
        scenario = new Scenario(response)
        showEverything()
        
    $('#run').click ->
      showEverything()
    
    $('canvas#simulation').click((e) ->
      obj = ctx.clickables.clickedOn(e.offsetX,e.offsetY)
      if obj
        uid = obj.id | obj.name
        if not $("div##{uid}").length
          $form = createFormFromObj(obj)
          $('#edit-node')
            .html($form)
            .find('input:first')
            .focus()
    )
