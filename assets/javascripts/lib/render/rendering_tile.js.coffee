class @RenderingTile extends Renderable
  createContent: =>
    @setData()
    @content = new PIXI.Text(@contentString, {font: "25px", fill: @contentColor})
    @updateContentPosition()

  updateSelf: =>
    unless @object["$updated?"]()
      @removeContent()
      @createContent()
      @gameWindow.stage.addChild(@content)
      @object["$updated!"]()

  setData: =>
    if @object["$marked_for_cleaning?"]()
      if @object.$content().constructor.name == "$Tree"
        @contentString = "t"
        @contentColor   = "red"
      else if @object.$content().constructor.name == "$FallenTree"
        @contentString = "/"
        @contentColor   = "red"
      else if @object.$content().constructor.name == "$BerriesBush"
        @contentString = "#"
        @contentColor   = "red"
    else
      if @object.$content().constructor.name == "$Tree"
        @contentString = "t"
        @contentColor = "green"
      else if @object.$content().constructor.name == "$FallenTree"
        @contentString = "/"
        @contentColor = "green"
      else if @object.$content().constructor.name == "$BerriesBush"
        @contentString = "#"
        @contentColor = "yellow"
      else if @object.$terrain() == "river"
        @contentString = "~"
        @contentColor   = "blue"
      else
        @contentString = "."
        @contentColor   = "white"
