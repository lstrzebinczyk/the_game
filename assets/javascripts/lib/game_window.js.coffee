
class @GameWindow
  constructor: (@engine) ->
    @stage = $("#stage")
    # interactive = true
    # @stage = new PIXI.Stage('000', interactive)

    # @playing = true
    # @x_offset = 0
    # @y_offset = 0
    # @change_offset = false

    # @width  = @engine.mapWidth()
    # @height = @engine.mapHeight()

    @renderedWidth  = 14 * 4
    @renderedHeight = 14 * 3

    @xOffset = 0
    @yOffset = 0
    @maxYOffset = @engine.mapWidth() - @renderedWidth
    @maxXOffset = @engine.mapHeight() - @renderedHeight

    @tileSize = 16


  update: =>
    @reRenderPeople()
    @renderFireplace()

  render: =>

  findStageTile: (height, width) =>
    @stage.find("#row_#{height}").find("#column_#{width}")

  renderFireplace: =>
    fireplace = @engine.fireplace
    x = fireplace.x() + @xOffset
    y = fireplace.y() + @yOffset
    stageTile = @findStageTile(x, y).find(".content")
    stageTile.addClass("structure-campfire")

  reRenderFireplace: =>
    @stage.find(".structure-campfire").removeClass("structure-campfire")
    @renderFireplace()

  renderStash: =>
    stash = @engine.stash
    x = stash.x() + @xOffset
    y = stash.y() + @yOffset
    stageTile = @findStageTile(x, y).find(".content")
    stageTile.addClass("structure-stash")

  reRenderStash: =>
    @stage.find(".structure-stash").removeClass("structure-stash")
    @renderFireplace()

  renderTerrain: =>
    @engine.eachTile (tile) =>
      x = tile.x() + @xOffset
      y = tile.y() + @yOffset
      stageTile = @findStageTile(x, y)
      terrainType = tile.terrain()
      stageTile.addClass("terrain-#{terrainType}")

  reRenderPeople: =>
    @engine.eachPerson (person) =>
      x = person.x() + @xOffset
      y = person.y() + @yOffset
      tile = @findStageTile(x, y).find(".content")
      type = person.type()
      id = person.id()

      @stage.find(".person-#{type}.person-#{id}").removeClass("person-#{type} person-#{id}")
      tile.addClass("person-#{type} person-#{id}")

  reRenderTerrain: =>
    @stage.find(".terrain-river").removeClass("terrain-river")
    @stage.find(".terrain-ground").removeClass("terrain-ground")
    @renderTerrain()

  setup: =>
    # INITIALIZE STAGE
    stage = ""
    for rowIndex in [0..@renderedHeight]
      stage += "<div class='row' id='row_#{rowIndex}'>"
      for columnIndex in [0..@renderedWidth]
        stage += "<span class='tile' id='column_#{columnIndex}'><span class='content'></span></span>"
      stage += "</div>"
    @stage.append(stage)

    @renderTerrain()
    @reRenderPeople()
    @renderFireplace()
    @renderStash()

    @stage.click (e) =>
      column = $(e.target).parent()
      x = parseInt(column.attr("id").replace("column_", ""))
      row = column.parent()
      y = parseInt(row.attr("id").replace("row_", ""))
      tile = @engine.findTile(y, x)
      console.log @engine.fireplace.fireplace
      console.log tile
    # @stage.mousemove (e) =>
    #   if @moving
    #     diffY = parseInt((@moveStartY - e.clientY) / @tileSize)
    #     diffX = parseInt((@moveStartX - e.clientX) / @tileSize)

    #     if diffX != 0 or diffY != 0
    #       @xOffset -= diffY
    #       @yOffset -= diffX
    #       @moveStartY = e.clientY
    #       @moveStartX = e.clientX

    #       if @xOffset < -@maxXOffset
    #         @xOffset = -@maxXOffset

    #       if @yOffset < -@maxYOffset
    #         @yOffset = -@maxYOffset

    #       if @xOffset > 0
    #         @xOffset = 0

    #       if @yOffset > 0
    #         @yOffset = 0

    #       @reRenderTerrain()
    #       @reRenderPeople()
    #       @reRenderFireplace()
    #       @renderStash()

    # $("body").mouseup =>
    #   @moving = false

    # @stage.mousedown (e) =>
    #   @moving = true
    #   @moveStartX = e.clientX
    #   @moveStartY = e.clientY

    # @stage.click (e) =>
      # console.log e


    # $("#view").append(@renderer.view)

    # groundTexture = new PIXI.Texture.fromImage("images/nature/ground.png")
    # riverTexture  = new PIXI.Texture.fromImage("images/nature/river.png")

    # requestAnimFrame( @render )

    # @renderTexture  = new PIXI.RenderTexture(@renderedWidth*@tileSize, @renderedHeight*@tileSize)
    # @renderTexture2 = new PIXI.RenderTexture(@renderedWidth*@tileSize, @renderedHeight*@tileSize)
    # @outputSprite  = new PIXI.Sprite(@renderTexture)

    # @outputSprite.position.x = @renderedWidth*@tileSize/2
    # @outputSprite.position.y = @renderedHeight*@tileSize/2

    # # outputSprite.anchor.x = 0.5
    # # outputSprite.anchor.y = 0.5

    # @stage.addChild(@outputSprite)

    # @terrainContainer = new PIXI.DisplayObjectContainer()
    # @terrainContainer.position.x = @renderedWidth*@tileSize/2;
    # @terrainContainer.position.y = @renderedHeight*@tileSize/2

    # @stage.addChild(@terrainContainer)

    # @engine.eachTile (tile) =>
    #   if tile.terrain() == "river"
    #     # sprite = new PIXI.Sprite(riverTexture)
    #     sprite = new PIXI.Sprite.fromImage("images/nature/river.png")
    #   else
    #     # sprite = new PIXI.Sprite(groundTexture)
    #     sprite = new PIXI.Sprite.fromImage("images/nature/ground.png")
    #   sprite.position.x = tile.y() * @tileSize + @x_offset
    #   sprite.position.y = tile.x() * @tileSize + @x_offset

    #   @terrainContainer.addChild(sprite)

    # renderTexture = new PIXI.RenderTexture(@renderedWidth*@tileSize, @renderedHeight*@tileSize)
    # terrainSprite = new PIXI.Sprite(renderTexture)
    # @stage.addChild(terrainSprite)

    # terrainContainer = new PIXI.SpriteBatch()
    # @stage.addChild(terrainContainer)

    # @engine.eachTile (tile) =>
    #   if tile.terrain() == "river"
    #     # sprite = new PIXI.Sprite(riverTexture)
    #     sprite = new PIXI.Sprite.fromImage("images/nature/river.png")
    #   else
    #     # sprite = new PIXI.Sprite(groundTexture)
    #     sprite = new PIXI.Sprite.fromImage("images/nature/ground.png")

    #   sprite.position.x = tile.y() * @tileSize + @x_offset
    #   sprite.position.y = tile.x() * @tileSize + @x_offset

    #   # renderTexture.render(sprite)
    #   terrainContainer.addChild(sprite)

    #   # renderTexture.render(sprite)

    # # @stage.addChild(terrainSprite)

    # requestAnimFrame( @render )

    #   eachTile: (block) =>
    # for tile in @tiles
    #   block(tile)

    # @stage.mousemove = (data) =>
    #   if @change_offset
    #     x = data.originalEvent.movementX
    #     y = data.originalEvent.movementY
    #     @x_offset += x
    #     @y_offset += y
    #     @x_offset = 0 if @x_offset > 0
    #     @y_offset = 0 if @y_offset > 0
    #     @x_offset = @maxXOffset if @x_offset < @maxXOffset
    #     @y_offset = @maxYOffset if @y_offset < @maxYOffset

    #   unless @playing
    #     @update()
    #     @render()

    # @stage.mouseup = =>
    #   @change_offset = false

    # @stage.mouseupoutside = =>
    #   @change_offset = false

    # @stage.mousedown = (mouseData) =>
    #   @change_offset = true

    #   mouse_x = mouseData.global.x
    #   mouse_y = mouseData.global.y
    #   map_x = parseInt(mouse_x / @tileSize)
    #   map_y = parseInt(mouse_y / @tileSize)
    #   tile = @engine.findTile(map_y, map_x)
    #   console.log tile
