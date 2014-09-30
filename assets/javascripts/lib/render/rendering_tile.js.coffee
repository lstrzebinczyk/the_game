class @RenderingTile extends Renderable
  createContent: =>
    @setData()
    @content = new PIXI.Text(@contentString, {font: "25px", fill: @contentColor})
    @updateContentPosition()

  updateSelf: =>
    if @object.isUpdated()
      @removeContent()
      @createContent()
      @gameWindow.stage.addChild(@content)
      @object.updated()

  setData: =>
    if @object.isMarkedForCleaning()
      if @object.contentName() == "$Tree"
        @contentString = "t"
        @contentColor   = "red"
      else if @object.contentName() == "$Piece"
        @contentString = "/"
        @contentColor   = "red"
      else if @object.contentName() == "$BerriesBush"
        @contentString = "#"
        @contentColor   = "red"
      else if @object.contentName() == "$Log"
        @contentString = "---"
        @contentColor = "green"
    else
      if @object.contentName() == "$Tree"
        @contentString = "t"
        @contentColor = "green"
      else if @object.contentName() == "$Log"
        @contentString = "---"
        @contentColor = "green"
      else if @object.contentName() == "$Piece"
        @contentString = "/"
        @contentColor = "green"
      else if @object.contentName() == "$BerriesBush"
        @contentString = "#"
        @contentColor = "yellow"
      else if @object.contentName() == "river"
        @contentString = "~"
        @contentColor   = "blue"
      else
        @contentString = "."
        @contentColor   = "white"
