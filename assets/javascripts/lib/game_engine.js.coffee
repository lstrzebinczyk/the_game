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
