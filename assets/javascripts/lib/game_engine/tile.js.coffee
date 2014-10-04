class @GameEngine.Tile
  constructor: (@tile) ->

  isNotMarkedForCleaning: =>
    @tile["$not_marked_for_cleaning?"]()

  contentType: =>
    @tile.$content().$type()

  terrain: =>
    @tile.$terrain()

  x: =>
    @tile.$x()

  y: =>
    @tile.$y()

