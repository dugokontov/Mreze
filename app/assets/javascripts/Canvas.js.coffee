class Box
  constructor: (@obj, @x, @y, @width, @height = @width)->
    
  isIn: (x,y)->
    true if @x <= x <= @x + @width and @y <= y <= @y + height

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
  isRight: (obj1Name, obj2Name, type = 'nodes', findByFieldname = 'name') ->
    box1 = @getBox(obj1Name, type, findByFieldname)
    box2 = @getBox(obj2Name, type, findByFieldname)
    return box1.x < box2.x

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
          return dfd.resolve() if count is 0
      )(startX, node, img) 
      img.src = "/assets/#{node.node_type}.png"
      startX += @nodeDistance    
  return dfd.promise()
@CanvasRenderingContext2D::drawInterfaces = (scenario) ->
  for i, node of scenario.node
    nodeBox = @clickables.getBox(node.name)
    for j, inter of node.interface
      connectedToNode = scenario.findNodeByInterfaceId(inter.connected_to_id)
      y = nodeBox.y + nodeBox.height / 2 - @interfaceBox / 2
      x = nodeBox.x + if @clickables.isRight(node.name, connectedToNode.name) then @interfaceBox / 2 else 0
      @fillRect(x, y, @interfaceBox, @interfaceBox)
      
      












