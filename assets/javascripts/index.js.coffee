#= require_tree ./lib

jQuery ->
  gameLoop = new GameLoop()
  gameLoop.setup()
  gameLoop.startGame()
