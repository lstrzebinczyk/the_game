class @GameEngine.Person
  constructor: (@person) ->

  type: =>
    @person.$type()

  thirst: =>
    @person.$thirst()

  hunger: =>
    @person.$hunger()

  energy: =>
    @person.$energy()

  actionDescription: =>
    @person.$action().$description()

  x: =>
    @person.$x()

  y: =>
    @person.$y()

