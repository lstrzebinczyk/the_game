class @GameEngine.Tile
  constructor: (@tile) ->
    @cachedContentName         = @contentName()
    @cachedIsMarkedForCleaning = @isNotMarkedForCleaning()

  isNotMarkedForCleaning: =>
    @tile["$not_marked_for_cleaning?"]()

  contentName: =>
    if @terrain() == "river"
      "river"
    else
      @tile.$content().$type()

  isUpdated: =>
    (@cachedContentName != @contentName()) or (@cachedIsMarkedForCleaning != @isNotMarkedForCleaning())

  updated: =>
    @cachedContentName = @contentName()
    @cachedIsMarkedForCleaning = @isNotMarkedForCleaning()

  terrain: =>
    @tile.$terrain()

  x: =>
    @tile.$x()

  y: =>
    @tile.$y()

