class @GameEngine
  constructor: ->
    @engine    = Opal.TheGame.Engine.$new()
    @stash     = new GameEngine.Stash()
    @dormitory = new GameEngine.Dormitory()
    @fireplace = new GameEngine.Fireplace()
    @people    = []

    for person in @engine.$people()
      @people.push(new GameEngine.Person(person))

  mapWidth: =>
    @engine.map.$width()

  mapHeight: =>
    @engine.map.$height()

  time: =>
    @engine.$time().$strftime("%T")

  update: =>
    @engine.$update()

  eachTile: (block) =>
    for row in @engine.$map().$grid()
      for tile in row
        block(tile)

  eachPerson: (block) =>
    for person in @people
      block(person)
