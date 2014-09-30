class @Renderable
  constructor: (@object, @gameWindow) ->
    @createContent()

    @renderedWidth  = @gameWindow.renderedWidth
    @renderedHeight = @gameWindow.renderedHeight

    @gameWindow.addChild(@)

  update: =>
    if @isWithinView()
      if @content
        @updateSelf()
        @updateContentPosition()
      else
        @createContent()
        @gameWindow.stage.addChild(@content)
        @updateContentPosition()
    else
      if @content
        @removeContent()

  updateSelf: ->

  isWithinView: =>
    @object.$y() * @gameWindow.tileSize >= - @gameWindow.x_offset and
    @object.$y() * @gameWindow.tileSize < - @gameWindow.x_offset + @renderedWidth*@gameWindow.tileSize and
    @object.$x() * @gameWindow.tileSize >= - @gameWindow.y_offset and
    @object.$x() * @gameWindow.tileSize < - @gameWindow.y_offset + @renderedHeight*@gameWindow.tileSize

  removeContent: =>
    @gameWindow.removeChild(@)

  updateContentPosition: =>
    @content.position.x = @object.$y() * @gameWindow.tileSize + @gameWindow.x_offset
    @content.position.y = @object.$x() * @gameWindow.tileSize + @gameWindow.y_offset
