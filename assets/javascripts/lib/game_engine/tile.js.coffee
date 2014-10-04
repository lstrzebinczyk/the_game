class @GameEngine.Tile
  constructor: (@tile) ->

  isNotMarkedForCleaning: =>
    @tile["$not_marked_for_cleaning?"]()

  contentName: =>
    if @terrain() == "river"
      "river"
    else
      @tile.$content().$type()

  terrain: =>
    @tile.$terrain()

  x: =>
    @tile.$x()

  y: =>
    @tile.$y()

