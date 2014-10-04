class @GameEngine.Stash
  constructor: ->
    @stash = Opal.TheGame.Settlement.$instance().$stash()

  itemTypes: =>
    @stash.$item_types()

  count: (type) =>
    @stash.$count(type)

  tilesCoords: =>
    @stash.$tiles_coords()

  x: =>
    @stash.$x()

  y: =>
    @stash.$y()

