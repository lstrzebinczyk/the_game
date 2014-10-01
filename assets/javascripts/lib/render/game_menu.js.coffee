class @GameMenu
  constructor: (@engine) ->
    @peopleStatsWindow    = $("#people")
    @stashStatsWindow     = $("#stash")
    @buildingStatsWindow  = $("#buildings")
    @timeWindow           = $("#time")

    @timeSinceLastCountUpdate      = new Date()
    @iterationsSinceLastCountUpdate = 0
    @turnsPerSecondWindow = $("#turns_count")

  update: =>
    @renderTime()
    @renderBuildingsStats()
    @renderStashStats()
    @renderPeopleStats()
    @renderTurnsPerSecond()

  renderTime: =>
    @timeWindow.text(@engine.time())

  renderBuildingsStats: =>
    @buildingStatsWindow.empty()
    unless @engine.dormitory.isNil()
      @buildingTemplate = "<div>"
      @buildingTemplate += "<div>DORMITORY:</div>"
      @buildingTemplate += "<div>status: #{@engine.dormitory.status()}</div>"
      if @engine.dormitory.status() == "plan"
        @buildingTemplate += "<div>firewood needed: #{@engine.dormitory.firewoodNeeded()}</div>"
      if @engine.dormitory.status() == "building"
        @buildingTemplate += "<div>construction left: #{@engine.dormitory.minutesLeft()}</div>"

      @buildingStatsWindow.append(@buildingTemplate)

  renderStashStats: =>
    @stashStatsWindow.empty()

    @stashTemplate = "<div>"
    for type in @engine.stash.itemTypes()
      @stashTemplate += "<div>#{type}: #{@engine.stash.count(type)}"
    @stashTemplate += "</div>"

    @stashStatsWindow.append(@stashTemplate)

  renderPeopleStats: =>
    @peopleStatsWindow.empty()
    @engine.eachPerson (person) =>
      type   = person.type()
      thirst = person.thirst()
      hunger = person.hunger()
      energy = person.energy()
      action_description = person.actionDescription()

      @peopleTemplate = """
      <div>
        <div>type: #{type}</div>
        <div>thirst: <progress value='#{thirst}'></progress></div>
        <div>hunger: <progress value='#{hunger}'></progress></div>
        <div>energy: <progress value='#{energy}'></progress></div>

        <div>action_description: #{action_description}</div>
        <br>
      </div>
      """

      @peopleStatsWindow.append(@peopleTemplate)

  renderTurnsPerSecond: =>
    @iterationsSinceLastCountUpdate += 1
    possibleNewTime = new Date()
    if possibleNewTime - @timeSinceLastCountUpdate > 1000
      @timeSinceLastCountUpdate = possibleNewTime
      @turnsPerSecondWindow.text(@iterationsSinceLastCountUpdate)
      @iterationsSinceLastCountUpdate = 0
