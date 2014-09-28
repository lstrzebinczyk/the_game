@render_people_stats = ->
  element = $("#people")
  element.empty()

  for person in @engine.$people()
    type   = person.$type()
    thirst = person.$thirst()
    hunger = person.$hunger()
    energy = person.$energy()
    action_description = person.$action().$description()

    # WOOT
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

    element.append(template)

@render_stash_stats = ->
  element = $("#stash")
  element.empty()

  stash = Opal.TheGame.Settlement.$instance().$stash()

  template = "<div>"
  for type in stash.$item_types()
    template += "<div>#{type}: #{stash.$count(type)}"
  template += "</div>"

  element.append(template)

  # template = """
  # <div>
  #   <div>type: #{type}</div>
  #   <div>thirst: #{thirst}</div>
  #   <div>hunger: #{hunger}</div>
  #   <div>energy: #{energy}</div>
  #   <div>action_description: #{action_description}</div>
  #   <br>
  # </div>
  # """

@engine = Opal.TheGame.Engine.$new()

$("#start").click =>
  # @engine = Opal.TheGame.Engine.$new()
  if playing
    clearInterval(gameLoop)
    @playing = false
    $("#start").text("Start!")
  else
    @gameLoop = setInterval(updateWorld, 1000/30)
    @playing = true
    $("#start").text("Stop!")


$("#progress").click ->
  engine.$update()
  render_people_stats()

render_people_stats()

@now = new Date

@render_turns_per_second = =>
  new_now = new Date()
  ms = new_now - @now
  @now = new_now
  tps = parseInt(1000.0 / ms)
  $("#turns_count").text(tps)

@render_time = ->
  time = engine.$time().$strftime("%T")
  $("#time").text(time)

@updateWorld = ->
  engine.$update()
  render_people_stats()
  render_turns_per_second()
  render_stash_stats()
  render_time()
  updateRenderObjects()


@gameLoop = setInterval(updateWorld, 1000/30)
@playing = true

interactive = true

# init black stage
stage = new PIXI.Stage('000', interactive)

stage.mousedown = (mousedata) ->
  mouse_x = mousedata.global.x
  mouse_y = mousedata.global.y

  map_x = parseInt(mouse_x / tileSize)
  map_y = parseInt(mouse_y / tileSize)

  tile = engine.$map().$fetch(map_y, map_x)
  console.log tile
  # console.log map_x
  # console.log map_y

  # console.log mousedata

# map size
width  = engine.map.$width()
height = engine.map.$height()

@tileSize = 16

# create a renderer instance.
renderer = PIXI.autoDetectRenderer(width*tileSize, height*tileSize)

# document.body.appendChild(renderer.view)
$("#view").append(renderer.view)

requestAnimFrame( animate )

updatable = []


# SETUP RENDERING MAP TILES
class @RenderingTile
  constructor: (@mapTile) ->
    @_setData()
    @text = new PIXI.Text(@content, {font: "25px", fill: @color})
    @text.position.x = @mapTile.$y() * tileSize
    @text.position.y = @mapTile.$x() * tileSize
    stage.addChild(@text)
    updatable.push(@)

  update: =>
    unless @mapTile["$updated?"]()
      @_setData()
      @text.setText(@content)
      @text.setStyle({font: "25px", fill: @color})
      @mapTile["$updated!"]()

  _setData: =>
    if @mapTile["$marked_for_cleaning?"]()
      if @mapTile.$content().constructor.name == "$Tree"
        @content = "t"
        @color   = "red"
      else if @mapTile.$content().constructor.name == "$FallenTree"
        @content = "/"
        @color   = "red"
      else if @mapTile.$content().constructor.name == "$BerriesBush"
        @content = "#"
        @color   = "red"
    else
      if @mapTile.$content().constructor.name == "$Tree"
        @content = "t"
        @color = "green"
      else if @mapTile.$content().constructor.name == "$FallenTree"
        @content = "/"
        @color = "green"
      else if @mapTile.$content().constructor.name == "$BerriesBush"
        @content = "#"
        @color = "yellow"
      else if @mapTile.$terrain() == "river"
        @content = "~"
        @color   = "blue"
      else
        @content = "."
        @color   = "white"

for row in engine.$map().$grid()
  for tile in row
    new RenderingTile(tile)

# SETUP RENDERING SETTLEMENT
settlement = Opal.TheGame.Settlement.$instance()

class @RenderingFireplace
  constructor: (@mapFireplace) ->
    @text = new PIXI.Text("F", {font: "25px", fill: "red"})
    @text.position.x = @mapFireplace.$y() * tileSize
    @text.position.y = @mapFireplace.$x() * tileSize
    stage.addChild(@text)
    updatable.push(@)

  update: =>

new RenderingFireplace(settlement.$fireplace())

class @RenderingStash
  constructor: (@mapStash) ->
    @text = new PIXI.Text("S", {font: "25px", fill: "white"})
    @text.position.x = @mapStash.$y() * tileSize
    @text.position.y = @mapStash.$x() * tileSize
    stage.addChild(@text)
    updatable.push(@)

  update: =>

new RenderingStash(settlement.$stash())

#SETUP RENDERING PEOPLE
class RenderingPerson
  constructor: (@person) ->
    if @person.$type() == "woodcutter"
      content = "W"
    else if @person.$type() == "leader"
      content = "L"
    else if @person.$type() == "gatherer"
      content = "G"
    else if @person.$type() == "fisherman"
      content = "F"

    @text = new PIXI.Text(content, {font: "25px", fill: "white"})
    @text.position.x = @person.$y() * tileSize
    @text.position.y = @person.$x() * tileSize

    stage.addChild(@text)
    updatable.push(@)

  update: =>
    @text.position.x = @person.$y() * tileSize
    @text.position.y = @person.$x() * tileSize

for person in engine.$people()
  new RenderingPerson(person)

class RenderingDormitory
  constructor: (@dormitory) ->
    @x = @dormitory.$y() * tileSize
    @y = @dormitory.$x() * tileSize
    @x_width = 4 * tileSize
    @y_width = 4 * tileSize

    @rectangle = new PIXI.Graphics()
    @rectangle.beginFill(0x0000FF, 0.3)
    @rectangle.drawRect(@x, @y, @x_width, @y_width)
    @rectangle.endFill()

    stage.addChild(@rectangle)
    updatable.push(@)

  update: =>
    if @dormitory.$status() == "done"
      @rectangle.beginFill(0x6F1C1C, 0.3)
      @rectangle.drawRect(@x, @y, @x_width, @y_width)
      @rectangle.endFill()


@updateRenderObjects = =>
  unless settlement.$dormitory()["$nil?"]()
    unless @renderingDormitory
      dormitory = settlement.$dormitory()
      @renderingDormitory = new RenderingDormitory(dormitory)

  for object in updatable
    object.update()

`
    function animate() {

        requestAnimFrame( animate );

        // just for fun, lets rotate mr rabbit a little
        // bunny.rotation += 0.1;


        // render the stage
        renderer.render(stage);
    }
`
