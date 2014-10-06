class @GameEngine.Tile
  constructor: (@tile) ->

  isNotMarkedForCleaning: =>
    @tile["$not_marked_for_cleaning?"]()

  contentType: =>
    @tile.$content().$type()

  buildingType: =>
    @tile.$building().$type()

  terrain: =>
    @tile.$terrain()

  isNil: =>
    @tile.$content()["$nil?"]()

  x: =>
    @tile.$x()

  y: =>
    @tile.$y()

