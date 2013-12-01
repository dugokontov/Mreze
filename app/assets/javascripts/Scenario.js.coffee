class @Scenario
  constructor: (scenario) ->
    $.extend(this, scenario)
  
  findNodeByName: (nodeName) ->
    @node.findFirst(-> @name = nodeName)
  
  findInterfaceById: (interfaceId) ->
    for i, node of @node
      if @node.hasOwnProperty(i)
        inte node node.interface.findFirst(-> Number(@id) is Number(interfaceId))
        return inte if inte?
    return null
    
  findNodeByInterfaceId: (interfaceId) ->
    for i, node of @node
      if @node.hasOwnProperty(i)
        inte = node.interface.findFirst(-> Number(@id) is Number(interfaceId))
        return node if inte?
    return null
    
class @Message
  constructor: (@source, @destination, @message = null) ->
    
  getWidth: (ctx) ->
    sourceWidth = ctx.measureText(@getSource()).width
    destWidth = ctx.measureText(@getDest()).width
    if @message
      return Math.max(sourceWidth, destWidth, @message.getWidth(ctx))
    else
      return Math.max(sourceWidth, destWidth)
  getSource: ->
    @sourceLabel + @source
  getDest: ->
    @destLabel + @destination
  getSourceProtocol: ->
    if @source.indexOf(':') == -1 then "ipv4" else "ipv6"
  getDestProtocol: ->
    if @destination.indexOf(':') == -1 then "ipv4" else "ipv6"
    
@Message::sourceLabel = "source: "
@Message::destLabel = "dest: "
