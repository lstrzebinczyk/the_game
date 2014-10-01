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

  inventoryItemTypes: =>
    @person.$inventory().$item_types()

  inventoryCount: (itemType) =>
    @person.$inventory().$count(itemType)

  x: =>
    @person.$x()

  y: =>
    @person.$y()

