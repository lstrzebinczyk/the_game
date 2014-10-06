
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

    @oftenUpdated = []

    @tileSize = 16


  update: =>
    if @engine.mapEvents().$size() > 0
      event = @engine.mapEvents().$pop()
      @rerenderContentBasedOnEvent(event)
      @oftenUpdated = @oftenUpdated.filter (tile) ->
        !tile.isNil()

    for tile in @oftenUpdated
      @cleanTile(tile)
      @renderContentTile(tile)


    @reRenderPeople()


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

    for coords in stash.tilesCoords()
      x = stash.x() + @xOffset + coords[0]
      y = stash.y() + @yOffset + coords[1]
      stageTile = @findStageTile(x, y).find(".content")
      stageTile.addClass("structure-stash structure-stash-#{coords[0]}-#{coords[1]}")

  reRenderStash: =>
    @stage.find(".structure-stash").attr("class", "content")
    @renderStash()

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

  rerenderContentBasedOnEvent: (mapEvent) =>
    x = mapEvent.$x()
    y = mapEvent.$y()
    tile = @engine.findTile(x, y)
    @cleanTile(tile)
    if mapEvent.$type() == "clean"

    else if mapEvent.$type() == "update"
      @oftenUpdated.push(tile)
      @renderContentTile(tile)

  cleanTile: (tile) =>
    x = tile.x() + @xOffset
    y = tile.y() + @yOffset
    stageTile = @findStageTile(x, y).find(".content")
    stageTile.attr("class", "content")

  renderContent: =>
    @engine.eachTile (tile) =>
      @renderContentTile(tile)

  renderContentTile: (tile) =>
    x = tile.x() + @xOffset
    y = tile.y() + @yOffset
    stageTile = @findStageTile(x, y).find(".content")
    if tile.contentType() == "tree"
      stageTile.addClass("nature-tree")
    else if tile.contentType() == "berries_bush"
      stageTile.addClass("berries-bush")
    else if tile.contentType() == "log_pile"
      logsCount = tile.tile.content.logs_count
      stageTile.addClass("nature-logs-#{logsCount}")

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
    @renderContent()

    @stage.click (e) =>
      column = $(e.target).parent()
      x = parseInt(column.attr("id").replace("column_", ""))
      row = column.parent()
      y = parseInt(row.attr("id").replace("row_", ""))
      tile = @engine.findTile(y, x)
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
    #       @reRenderStash()

    # $("body").mouseup =>
    #   @moving = false

    # @stage.mousedown (e) =>
    #   @moving = true
    #   @moveStartX = e.clientX
    #   @moveStartY = e.clientY

    # @stage.click (e) =>
      # console.log e
