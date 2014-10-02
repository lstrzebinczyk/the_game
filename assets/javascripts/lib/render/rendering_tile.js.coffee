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
    if @object.isNotMarkedForCleaning()
      if @object.contentName() == "tree"
        @contentString = "t"
        @contentColor = "green"
      else if @object.contentName() == "log"
        @contentString = "---"
        @contentColor = "green"
      else if @object.contentName() == "tree_piece"
        @contentString = "/"
        @contentColor = "green"
      else if @object.contentName() == "berries_bush"
        @contentString = "#"
        @contentColor = "yellow"
      else if @object.contentName() == "river"
        @contentString = "~"
        @contentColor   = "blue"
      else
        @contentString = "."
        @contentColor   = "white"
    else
      if @object.contentName() == "tree"
        @contentString = "t"
        @contentColor   = "red"
      else if @object.contentName() == "tree_piece"
        @contentString = "/"
        @contentColor   = "red"
      else if @object.contentName() == "berries_bush"
        @contentString = "#"
        @contentColor   = "red"
      else if @object.contentName() == "log"
        @contentString = "---"
        @contentColor = "red"
      else
        @contentString = "."
        @contentColor   = "white"
