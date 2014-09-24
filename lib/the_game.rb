require 'require_all'
require "curses"
require "pry"

require_all "lib"

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
        # sleep(0.01)
      end
    ensure
      @window.close
    end
  end

  def map
    @engine.map
  end
end
