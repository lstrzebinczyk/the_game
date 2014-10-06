class @GameEngine.Person
  constructor: (@person) ->

  id: ->
    @person._id

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

  inventoryItemTypes: =>
    @person.$inventory().$item_types()

  inventoryCount: (itemType) =>
    @person.$inventory().$count(itemType)

  waterskinPercentage: =>
    @person.$waterskin().$units() / @person.$waterskin().$capacity()

  x: =>
    @person.$x()

  y: =>
    @person.$y()

