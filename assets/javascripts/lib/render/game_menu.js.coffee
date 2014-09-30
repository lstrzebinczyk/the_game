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
      template = "<div>"
      template += "<div>DORMITORY:</div>"
      template += "<div>status: #{@engine.dormitory.status()}</div>"
      if @engine.dormitory.status() == "plan"
        template += "<div>firewood needed: #{@engine.dormitory.firewoodNeeded()}</div>"
      if @engine.dormitory.status() == "building"
        template += "<div>construction left: #{@engine.dormitory.minutesLeft()}</div>"

      @buildingStatsWindow.append(template)

  renderStashStats: =>
    @stashStatsWindow.empty()

    template = "<div>"
    for type in @engine.stash.itemTypes()
      template += "<div>#{type}: #{@engine.stash.count(type)}"
    template += "</div>"

    @stashStatsWindow.append(template)

  renderPeopleStats: =>
    @peopleStatsWindow.empty()
    for person in @engine.people()
      type   = person.$type()
      thirst = person.$thirst()
      hunger = person.$hunger()
      energy = person.$energy()
      action_description = person.$action().$description()

      progress = (value) ->
        "<progress value='#{value}'></progress>"

      template = """
      <div>
        <div>type: #{type}</div>
        <div>thirst: #{progress(thirst)}</div>
        <div>hunger: #{progress(hunger)}</div>
        <div>energy: #{progress(energy)}</div>
        <div>action_description: #{action_description}</div>
        <br>
      </div>
      """

      @peopleStatsWindow.append(template)

  renderTurnsPerSecond: =>
    @iterationsSinceLastCountUpdate += 1
    possibleNewTime = new Date()
    if possibleNewTime - @timeSinceLastCountUpdate > 1000
      @timeSinceLastCountUpdate = possibleNewTime
      @turnsPerSecondWindow.text(@iterationsSinceLastCountUpdate)
      @iterationsSinceLastCountUpdate = 0
