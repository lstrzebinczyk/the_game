class @GameEngine.Fireplace
  constructor: ->
    @fireplace = Opal.TheGame.Settlement.$instance().$fireplace()

  $x: =>
    @fireplace.$x()

  $y: =>
    @fireplace.$y()

