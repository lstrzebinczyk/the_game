@render_people_stats = ->
  element = $("#people")
  element.empty()

  for person in @engine.$people()
    type   = person.$type()
    thirst = person.$thirst()
    hunger = person.$hunger()
    energy = person.$energy()
    action_description = person.$action().$description()

    template = """
    <div>
      <div>type: #{type}</div>
      <div>thirst: #{thirst}</div>
      <div>hunger: #{hunger}</div>
      <div>energy: #{energy}</div>
      <div>action_description: #{action_description}</div>
      <br>
    </div>
    """

    element.append(template)

@engine = Opal.TheGame.Engine.$new()

$("#start").click =>
  # @engine = Opal.TheGame.Engine.$new()
  if playing
    clearInterval(gameLoop)
    @playing = false
    $("#start").text("Start!")
  else
    @gameLoop = setInterval(updateWorld, 1)
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

@updateWorld = ->
  engine.$update()
  render_people_stats()
  render_turns_per_second()
  updateRenderObjects()


@gameLoop = setInterval(updateWorld, 1)
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

document.body.appendChild(renderer.view)
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
    @_setData()
    @text.setText(@content)
    @text.setStyle({font: "25px", fill: @color})

  _setData: =>
    if @mapTile["$marked_for_cleaning?"]()
      # console.log(@mapTile)
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

# class Test

#   test = new Test()

#   stage.addChild(test)

`
    function animate() {

        requestAnimFrame( animate );

        // just for fun, lets rotate mr rabbit a little
        // bunny.rotation += 0.1;


        // render the stage
        renderer.render(stage);
    }
`


    # var stage = new PIXI.Stage(000);


    # width  = engine.map.$width()
    # height = engine.map.$height()

    # // add the renderer view element to the DOM
    # document.body.appendChild(renderer.view);

    # requestAnimFrame( animate );

    # // create a texture from an image path
    # // var texture = PIXI.Texture.fromImage("bunny.png");
    # // create a new Sprite using the texture
    # // var bunny = new PIXI.Sprite(texture);

    # // center the sprites anchor point
    # // bunny.anchor.x = 0.5;
    # // bunny.anchor.y = 0.5;

    # // move the sprite t the center of the screen
    # // bunny.position.x = 200;
    # // bunny.position.y = 150;

    # // stage.addChild(bunny);

    # var textSample = new PIXI.Text(".", {font: "35px Snippet", fill: "white", align: "left"});

    # map = engine.$map()

    # for(i = 0; i < width; i++){
    #   for(j = 0; j < height; j++){

    #   }
    # }











# for tile in @engine.$map()


# stage = new PIXI.Stage(0x66FF99)
# renderer = PIXI.autoDetectRenderer(400, 300)
# document.body.appendChild(renderer.view);
# requestAnimFrame( animate )

# `
# function animate() {
#   requestAnimFrame( animate );
#   renderer.render(stage);
# }
# `

# animate = ->
#   requestAnimFrame( animate )
#   renderer.render(stage)
#   null

    # def render_people_stats
    #   setpos(0, map.width + 2)
    #   addstr " " * 50
    #   setpos(0, map.width + 2)
    #   addstr("Alive: #{people.size}")

    #   people.each_with_index do |person, index|
    #     setpos(2 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(2 + 6 * index, map.width + 2)
    #     addstr("Person (#{person.type}) stats:")

    #     setpos(3 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(3 + 6 * index, map.width + 2)
    #     addstr("  thirst: #{progress_bar(person.thirst)}")

    #     setpos(4 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(4 + 6 * index, map.width + 2)
    #     addstr("  hunger: #{progress_bar(person.hunger)}")

    #     setpos(5 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(5 + 6 * index, map.width + 2)
    #     addstr("  energy: #{progress_bar(person.energy)}")

    #     setpos(6 + 6 * index, map.width + 2)
    #     addstr " " * 50
    #     setpos(6 + 6 * index, map.width + 2)
    #     addstr("  action: #{person.action.description}")
    #   end
    # end

# for person in engine.people
#   console.log person

# engine.$update()

# for person in engine.people
#   console.log person

# console.log "penis"

# engine = Opal.TheGame.Engine.$new()
# console.log(engine)

# engine.$people(function(entry) {
#   console.log(entry);
# });
# for person in temp1.$people(){
#   console.log person
# }

# class TheGame
#   # def setup
#   #   @engine = Engine.new
#   #   @window = Window.new(@engine)
#   # end

#   # def window
#   #   @window
#   # end

#   # def start
#   #   @window.init
#   #   begin
#   #     while true
#   #       @engine.update
#   #       @window.render
#   #       sleep(0.033)
#   #       # sleep 0.1
#   #     end
#   #   ensure
#   #     @window.close
#   #   end
#   # end

#   # def map
#   #   @engine.map
#   # end
# end
