require_relative "logger"
require_relative "the_game/has_position"
require_relative "the_game/person"
require_relative "the_game/map"
require_relative "the_game/engine"
require_relative "the_game/window"
require_relative "the_game/food"
require_relative "the_game/container"

require "pry"

class TheGame
  def setup
    @engine = Engine.new
    @window = Window.new(@engine)
  end

  def window
    @window
  end

  def start
    @window.init
    begin
      while true
        @engine.update
        @window.render
        sleep(0.1)
      end
    ensure
      @window.close
    end
  end

  def map
    @engine.map
  end
end
