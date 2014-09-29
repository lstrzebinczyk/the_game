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
  renderer.render(stage)


@gameLoop = setInterval(updateWorld, 1000/30)
@playing = true

interactive = true

# init black stage
@stage = new PIXI.Stage('000', interactive)

@x_offset = 0
@y_offset = 0
@change_offset = false

@width  = engine.map.$width()
@height = engine.map.$height()


@renderedWidth  = 14 * 4
@renderedHeight = 14 * 3

@tileSize = 16

@maxXOffset = (@renderedWidth  - @width ) * @tileSize
@maxYOffset = (@renderedHeight - @height) * @tileSize

stage.mousemove = (data) =>
  if @change_offset
    x = data.originalEvent.movementX
    y = data.originalEvent.movementY
    @x_offset += x
    @y_offset += y
    @x_offset = 0 if @x_offset > 0
    @y_offset = 0 if @y_offset > 0
    @x_offset = @maxXOffset if @x_offset < @maxXOffset
    @y_offset = @maxYOffset if @y_offset < @maxYOffset

stage.mouseup = =>
  @change_offset = false

stage.mousedown = =>
  @change_offset = true

# create a renderer instance.
renderer = PIXI.autoDetectRenderer(renderedWidth*tileSize, renderedHeight*tileSize)

# document.body.appendChild(renderer.view)
$("#view").append(renderer.view)

# requestAnimFrame( animate )

updatable = []

class @Renderable
  constructor: (@object) ->
    @createContent()

    # cache these so that you don't have to ask window for them
    @renderedWidth = renderedWidth
    @renderedHeight = renderedHeight


    stage.addChild(@content)
    updatable.push(@)

  update: =>
    if @isWithinView()
      if @content
        @updateSelf()
        @updateContentPosition()
      else
        @createContent()
        stage.addChild(@content)
        @updateContentPosition()
    else
      if @content
        @removeContent()

  updateSelf: ->

  isWithinView: =>
    @object.$y() * tileSize >= - window.x_offset and
    @object.$y() * tileSize < - window.x_offset + @renderedWidth*tileSize and
    @object.$x() * tileSize >= - window.y_offset and
    @object.$x() * tileSize < - window.y_offset + @renderedHeight*tileSize

  removeContent: =>
    stage.removeChild(@content)
    @content = null

  updateContentPosition: =>
    @content.position.x = @object.$y() * tileSize + window.x_offset
    @content.position.y = @object.$x() * tileSize + window.y_offset

class @RenderingTile extends Renderable
  createContent: =>
    @setData()
    @content = new PIXI.Text(@contentString, {font: "25px", fill: @contentColor})
    @updateContentPosition()

  updateSelf: =>
    unless @object["$updated?"]()
      @removeContent()
      @createContent()
      stage.addChild(@content)
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

for row in engine.$map().$grid()
  for tile in row
    new RenderingTile(tile)

# SETUP RENDERING SETTLEMENT
settlement = Opal.TheGame.Settlement.$instance()

class @RenderingFireplace extends Renderable
  createContent: =>
    @content = new PIXI.Text("F", {font: "25px", fill: "red"})

new RenderingFireplace(settlement.$fireplace())

class @RenderingStash extends Renderable
  createContent: =>
    @content = new PIXI.Text("S", {font: "25px", fill: "white"})

new RenderingStash(settlement.$stash())

class RenderingPerson extends Renderable
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

for person in engine.$people()
  new RenderingPerson(person)

class RenderingDormitory extends Renderable
  createContent: =>
    @color = 0x0000FF unless @color
    @content = new PIXI.Graphics()
    @draw()

  draw: =>
    # console.log @tileSize
    @content.beginFill(@color, 0.3)
    @content.drawRect(0, 0, 4 * tileSize, 4 * tileSize)
    @content.endFill()

  updateSelf: =>
    if @object.$status() == "done"
      @color = 0x6F1C1C
      @draw()

  # updateContentPosition: =>
  #   @content.position.x = @object.$y() * @tileSize + window.x_offset
  #   @content.position.y = @object.$x() * @tileSize + window.y_offset

@updateRenderObjects = =>
  unless settlement.$dormitory()["$nil?"]()
    unless @renderingDormitory
      dormitory = settlement.$dormitory()
      @renderingDormitory = new RenderingDormitory(dormitory)

  for object in updatable
    object.update()

# `
#     function animate() {

#         requestAnimFrame( animate );

#         // just for fun, lets rotate mr rabbit a little
#         // bunny.rotation += 0.1;


#         // render the stage
#         renderer.render(stage);
#     }
# `
