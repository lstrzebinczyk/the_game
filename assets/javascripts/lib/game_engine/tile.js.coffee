class @GameEngine.Tile
  constructor: (@tile) ->
    @cachedContentName         = @contentName()
    @cachedIsMarkedForCleaning = @isMarkedForCleaning()

  isMarkedForCleaning: =>
    @tile["$marked_for_cleaning?"]()

  contentName: =>
    if @tile.$terrain() == "river"
      "river"
    else
      @tile.$content().$type()

  isUpdated: =>
    (@cachedContentName != @contentName()) or (@cachedIsMarkedForCleaning != @isMarkedForCleaning())

  updated: =>
    @cachedContentName = @contentName()
    @cachedIsMarkedForCleaning = @isMarkedForCleaning()

  x: =>
    @tile.$x()

  y: =>
    @tile.$y()

