# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('canvas#simulation').length
    $.getJSON(location.href)
      .done (response) ->
        console.log(response)
    
