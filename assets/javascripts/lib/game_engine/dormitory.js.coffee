class @GameEngine.Dormitory
  constructor: ->
    @settlement = Opal.TheGame.Settlement.$instance()
    # @dormitory = Opal.TheGame.Settlement.$instance().$dormitory()

  isNil: =>
    @settlement.$dormitory()["$nil?"]()

  status: =>
    @settlement.$dormitory().$status()

  firewoodNeeded: =>
    @settlement.$dormitory().$firewood_needed()

  minutesLeft: =>
    @settlement.$dormitory().$minutes_left()

  dormitory: =>
    Opal.TheGame.Settlement.$instance().$dormitory()
