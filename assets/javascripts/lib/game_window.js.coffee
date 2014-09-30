
class @GameWindow
  constructor: (@engine) ->
    interactive = true
    @stage = new PIXI.Stage('000', interactive)

    @playing = true
    @x_offset = 0
    @y_offset = 0
    @change_offset = false

    @width  = @engine.mapWidth()
    @height = @engine.mapHeight()

    @renderedWidth  = 14 * 4
    @renderedHeight = 14 * 3

    @tileSize = 16

    @maxXOffset = (@renderedWidth  - @width ) * @tileSize
    @maxYOffset = (@renderedHeight - @height) * @tileSize

    @renderer = PIXI.autoDetectRenderer(@renderedWidth*@tileSize, @renderedHeight*@tileSize)

    @updatable = []

  update: =>
    unless @engine.dormitory.isNil()
      unless @renderingDormitory
        @renderingDormitory = new RenderingDormitory(@engine.dormitory.dormitory(), @)

    for object in @updatable
      object.update()

  render: =>
    @renderer.render(@stage)

  addChild: (child) =>
    @stage.addChild(child.content)
    @updatable.push(child)

  removeChild: (child) =>
    @stage.removeChild(child.content)
    child.content = null

  setup: =>
    $("#view").append(@renderer.view)

    @engine.eachTile (tile) =>
      new RenderingTile(tile, @)

    new RenderingFireplace(@engine.fireplace(), @)
    new RenderingStash(@engine.stash.stash, @)

    for person in @engine.people()
      new RenderingPerson(person, @)

    @stage.mousemove = (data) =>
      if @change_offset
        x = data.originalEvent.movementX
        y = data.originalEvent.movementY
        @x_offset += x
        @y_offset += y
        @x_offset = 0 if @x_offset > 0
        @y_offset = 0 if @y_offset > 0
        @x_offset = @maxXOffset if @x_offset < @maxXOffset
        @y_offset = @maxYOffset if @y_offset < @maxYOffset

      unless @playing
        @update()
        @render()

    @stage.mouseup = =>
      @change_offset = false

    @stage.mouseupoutside = =>
      @change_offset = false

    @stage.mousedown = =>
      @change_offset = true
