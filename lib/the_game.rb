require_relative "the_game/map"
require_relative "the_game/engine"
require_relative "the_game/window"

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
      # @window.cr
      # while true
        # @engine.update
        # while true

        # trap

        while true
          @engine.update
          @window.render
        end
        # require "pry"
        # binding.pry
        # end
      # end
      # end
    # ensure
      # @window.close
    # end

    # @window.init
    # begin
    #   while true
    #     @window.render
    #   end
    ensure
      @window.close
    end
  end

  def map
    @engine.map
  end
end
