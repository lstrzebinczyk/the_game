# window.TheGame = {}

##= require_tree ./lib

class @GameEngine
  constructor: ->
    @engine    = Opal.TheGame.Engine.$new()
    @stash     = new GameEngine.Stash()
    @dormitory = new GameEngine.Dormitory()

  people: =>
    @engine.$people()

  mapWidth: =>
    @engine.map.$width()

  mapHeight: =>
    @engine.map.$height()

  time: =>
    @engine.$time().$strftime("%T")

  update: =>
    @engine.$update()

  fireplace: =>
    settlement = Opal.TheGame.Settlement.$instance()
    settlement.$fireplace()

  eachTile: (block) =>
    for row in @engine.$map().$grid()
      for tile in row
        block(tile)
        # new RenderingTile(tile, self)

class @GameEngine.Stash
  constructor: ->
    @stash = Opal.TheGame.Settlement.$instance().$stash()

  itemTypes: =>
    @stash.$item_types()

  count: (type) =>
    @stash.$count(type)

class @GameEngine.Dormitory
  constructor: ->
    @settlement = Opal.TheGame.Settlement.$instance()
    # @dormitory = Opal.TheGame.Settlement.$instance().$dormitory()

  isNil: =>
    @settlement.$dormitory()["$nil?"]()

  status: =>
    @settlement.$dormitory().$status()

  firewoodNeeded: =>
    @settlement.$dormitory().$firewood_needed()

  minutesLeft: =>
    @settlement.$dormitory().$minutes_left()

  dormitory: =>
    Opal.TheGame.Settlement.$instance().$dormitory()

class @GameMenu
  constructor: (@engine) ->
    @peopleStatsWindow    = $("#people")
    @stashStatsWindow     = $("#stash")
    @buildingStatsWindow  = $("#buildings")
    @timeWindow           = $("#time")

    @timeSinceLastCountUpdate      = new Date()
    @iterationsSinceLastCountUpdate = 0
    @turnsPerSecondWindow = $("#turns_count")

  update: =>
    @renderTime()
    @renderBuildingsStats()
    @renderStashStats()
    @renderPeopleStats()
    @renderTurnsPerSecond()

  renderTime: =>
    @timeWindow.text(@engine.time())

  renderBuildingsStats: =>
    @buildingStatsWindow.empty()
    unless @engine.dormitory.isNil()
      template = "<div>"
      template += "<div>DORMITORY:</div>"
      template += "<div>status: #{@engine.dormitory.status()}</div>"
      if @engine.dormitory.status() == "plan"
        template += "<div>firewood needed: #{@engine.dormitory.firewoodNeeded()}</div>"
      if @engine.dormitory.status() == "building"
        template += "<div>construction left: #{@engine.dormitory.minutesLeft()}</div>"

      @buildingStatsWindow.append(template)

  renderStashStats: =>
    @stashStatsWindow.empty()

    template = "<div>"
    for type in @engine.stash.itemTypes()
      template += "<div>#{type}: #{@engine.stash.count(type)}"
    template += "</div>"

    @stashStatsWindow.append(template)

  renderPeopleStats: =>
    @peopleStatsWindow.empty()
    for person in @engine.people()
      type   = person.$type()
      thirst = person.$thirst()
      hunger = person.$hunger()
      energy = person.$energy()
      action_description = person.$action().$description()

      progress = (value) ->
        "<progress value='#{value}'></progress>"

      template = """
      <div>
        <div>type: #{type}</div>
        <div>thirst: #{progress(thirst)}</div>
        <div>hunger: #{progress(hunger)}</div>
        <div>energy: #{progress(energy)}</div>
        <div>action_description: #{action_description}</div>
        <br>
      </div>
      """

      @peopleStatsWindow.append(template)

  renderTurnsPerSecond: =>
    @iterationsSinceLastCountUpdate += 1
    possibleNewTime = new Date()
    if possibleNewTime - @timeSinceLastCountUpdate > 1000
      @timeSinceLastCountUpdate = possibleNewTime
      @turnsPerSecondWindow.text(@iterationsSinceLastCountUpdate)
      @iterationsSinceLastCountUpdate = 0

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

    # for row in @engine.$map().$grid()
    #   for tile in row

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


class @GameLoop
  constructor: ->
    @gameEngine = new GameEngine()
    @gameMenu   = new GameMenu(@gameEngine)
    @gameWindow = new GameWindow(@gameEngine)

    @startButton = $("#start")

  setup: =>
    @startButton.click =>
      if @playing
        @stopGame()
      else
        @startGame()

    @gameWindow.setup()

  update: =>
    @gameEngine.update()
    @gameMenu.update()
    @gameWindow.update()
    @gameWindow.render()

  startGame: =>
    @gameLoop = setInterval(@update, 1000/30)
    @playing = true
    @startButton.text("Stop!")

  stopGame: =>
    clearInterval(@gameLoop)
    @playing = false
    @startButton.text("Start!")

jQuery ->
  gameLoop = new GameLoop()
  gameLoop.setup()
  gameLoop.startGame()

class @Renderable
  constructor: (@object, @gameWindow) ->
    @createContent()

    # cache these so that you don't have to ask window for them
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

class @RenderingFireplace extends Renderable
  createContent: =>
    @content = new PIXI.Text("F", {font: "25px", fill: "red"})

class @RenderingStash extends Renderable
  createContent: =>
    @content = new PIXI.Text("S", {font: "25px", fill: "white"})

class @RenderingPerson extends Renderable
  createContent: =>
    if @object.$type() == "woodcutter"
      content = "W"
    else if @object.$type() == "leader"
      content = "L"
    else if @object.$type() == "gatherer"
      content = "G"
    else if @object.$type() == "fisherman"
      content = "F"

    @content = new PIXI.Text(content, {font: "25px", fill: "white"})

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
