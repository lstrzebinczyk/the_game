class @RenderingDormitory extends Renderable
  createContent: =>
    @color = 0x0000FF unless @color
    @content = new PIXI.Graphics()
    @draw()

  draw: =>
    @content.beginFill(@color, 0.3)
    @content.drawRect(0, 0, 4 * @gameWindow.tileSize, 4 * @gameWindow.tileSize)
    @content.endFill()

  updateSelf: =>
    if @object.$status() == "done"
      @color = 0x6F1C1C
      @draw()
