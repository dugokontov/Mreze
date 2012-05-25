class @Scenario
  constructor: (scenario) ->
    $.extend(this, scenario)
  
  findNodeByName: (nodeName) ->
    @node.findFirst(-> @name = nodeName)
  
  findInterfaceById: (interfaceId) ->
    for i, node of @node
      if nodes.hasOwnProperty(i)
        inte node node.interface.findFirst(-> @id = interfaceId)
        return inte if inte?
    return null
    
  findNodeByInterfaceId: (interfaceId) ->
    for i, node of @node
      if node.hasOwnProperty(i)
        inte = node.interface.findFirst(-> @id = interfaceId)
        return node if inte?
    return null
