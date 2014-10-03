class @GameLoop
  constructor: ->
    @gameEngine = new GameEngine()
    @gameMenu   = new GameMenu(@gameEngine)
    @gameWindow = new GameWindow(@gameEngine)

    @startButton = $("#start")

    @expectedTurnsPerSecond = 30

  setup: =>
    @startButton.click =>
      if @playing
        @stopGame()
      else
        @startGame()

    @gameWindow.setup()

    $("#slow").click =>
      $(".speed_control").removeClass("active")
      $("#slow").addClass("active")
      @expectedTurnsPerSecond = 30
      @stopGame()
      @startGame()

    $("#fast").addClass("active")
    $("#fast").click =>
      $(".speed_control").removeClass("active")
      $("#fast").addClass("active")
      @expectedTurnsPerSecond = 60
      @stopGame()
      @startGame()

    $("#max").click =>
      $(".speed_control").removeClass("active")
      $("#max").addClass("active")
      @expectedTurnsPerSecond = 1000
      @stopGame()
      @startGame()


  update: =>
    @gameEngine.update()
    @gameMenu.update()
    @gameWindow.update()
    @gameWindow.render()

  startGame: =>
    @gameLoop = setInterval(@update, 1000/@expectedTurnsPerSecond)
    @playing = true
    @gameWindow.playing = true
    @startButton.text("Stop!")

  stopGame: =>
    clearInterval(@gameLoop)
    @playing = false
    @gameWindow.playing = false
    @startButton.text("Start!")
