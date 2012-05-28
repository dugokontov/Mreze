class Box
  constructor: (@obj, @x, @y, @width, @height = @width)->
    
  isIn: (x,y)->
    true if @x <= x <= @x + @width and @y <= y <= @y + height
    
@CanvasRenderingContext2D::setFontSize = (size) ->
  @font = "#{size}px Times New Roman"

@CanvasRenderingContext2D::nodeDistance = 200
@CanvasRenderingContext2D::interfaceBox = 10
@CanvasRenderingContext2D::clickables =
  inter: []
  nodes: []
  clickedOn: (x, y) ->
    for clickableName, clickableArray of this
      if clickableArray instanceof Array
        elem = clickableArray.findFirst(-> @isIn(x, y))
        return elem.obj if elem?
  getBox: (objName, type = 'nodes', findByFieldname = 'name') ->
    @[type].findFirst(-> @obj[findByFieldname] is objName)
  getInter: (id) ->
    @inter.findFirst(-> Number(@obj.id) is Number(id))
  isRight: (obj1Name, obj2Name, type = 'nodes', findByFieldname = 'name') ->
    box1 = @getBox(obj1Name, type, findByFieldname)
    box2 = @getBox(obj2Name, type, findByFieldname)
    return box1.x < box2.x

@CanvasRenderingContext2D::centerText = (text, x, y) ->
  measure = @measureText(text)
  @fillText(text, x - measure.width / 2, y)

@CanvasRenderingContext2D::drawMessage = (message, x, y, background = "#ffffff") ->
  @save()
  fontSize = 14
  @setFontSize(fontSize)
  @fillStyle = background
  msgWidth = message.getWidth(this)
  boxHeigth = fontSize * 2 + 6;
  @fillRect(x, y, msgWidth + 6, boxHeigth)
  @strokeRect(x, y, msgWidth + 6, boxHeigth)
  centerX = x + (msgWidth + 6) / 2
  @fillStyle = "red"
  @centerText(message.getSource(), centerX, y + fontSize)
  @fillStyle = "blue"
  @centerText(message.getDest(), centerX, y + 2 * fontSize)
  @restore()
  if message.message
    @drawMessage(message.message, x, y + boxHeigth)
  
  
@CanvasRenderingContext2D::drawNodes = (nodes) ->
  dfd = new jQuery.Deferred()
  startX = 50
  startY = 100
  count = nodes.length
  that = this
  for index, node of nodes
    if nodes.hasOwnProperty(index)
      img = new Image()
      img.onload = ((start, node, img) ->
        ->
          that.drawImage(img, start, startY)
          that.clickables.nodes.push(new Box(node, start, startY, img.width, img.height))
          count--
          that.save()
          that.setFontSize(18)
          that.centerText(node.name, start + img.width / 2, startY - 10)
          that.restore()
          return dfd.resolve() if count is 0
      )(startX, node, img) 
      img.src = "/assets/#{node.node_type}.png"
      startX += @nodeDistance    
  return dfd.promise()
@CanvasRenderingContext2D::drawInterfaces = (scenario) ->
  for i, node of scenario.node
    if scenario.node.hasOwnProperty(i)
      nodeBox = @clickables.getBox(node.name)
      for j, inter of node.interface
        if node.interface.hasOwnProperty(j)
          connectedToNode = scenario.findNodeByInterfaceId(inter.connected_to_id)
          y = nodeBox.y + nodeBox.height / 2 - @interfaceBox / 2
          x = nodeBox.x - @interfaceBox / 2 + if @clickables.isRight(node.name, connectedToNode.name) then nodeBox.width else 0
          @fillRect(x, y, @interfaceBox, @interfaceBox)
          @clickables.inter.push(new Box(inter, x, y, @interfaceBox))
  return @drawConnections()
@CanvasRenderingContext2D::drawConnections = ->
  @save()
  @setFontSize(15)
  for i, interBox of @clickables.inter
    if @clickables.inter.hasOwnProperty(i)
      connectToBox = @clickables.inter.findFirst(-> Number(this.obj.id) is Number(interBox.obj.connected_to_id))
      @beginPath()
      offset = @interfaceBox / 2
      @moveTo(interBox.x + offset, interBox.y + offset)
      @lineTo(connectToBox.x + offset, connectToBox.y + offset)
      @stroke()
      @centerText(interBox.obj.protocol, (interBox.x + connectToBox.x) / 2, (interBox.y + connectToBox.y) / 2)
  @restore()
  return this
@CanvasRenderingContext2D::drawMessageFlow = (scenario) ->
  that = this
  fromInterface = scenario.node[0].interface[0]
  toInterface = scenario.node[scenario.node.length - 1].interface[0]
  message = new Message(fromInterface.ip_address, toInterface.ip_address)
  messagePositionY = 220
  route = (msg, interfaceFrom) ->
    interfaceBox = that.clickables.getInter(interfaceFrom.id)
    that.drawMessage(msg, interfaceBox.x, messagePositionY)
    nodeTo = scenario.findNodeByInterfaceId(interfaceFrom.connected_to_id)
    if nodeTo.interface.length > 1
      interfaceOut = nodeTo.interface.findFirst(-> Number(@id) != interfaceFrom.connected_to_id)
      $.ajax
        url: '/rounting_rules/find'
        data:
          scenario_type: scenario.scenario_type
          node_type: nodeTo.node_type
          protocol_in: interfaceFrom.protocol
          protocol_out: interfaceOut.protocol 
  route(message, fromInterface)
    
  













