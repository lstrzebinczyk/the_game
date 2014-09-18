require "curses"

class TheGame
  class Window
    include Curses

    def initialize(engine)
      @engine = engine
    end

    def map
      @engine.map
    end

    def init
      init_screen
    end

    def close
      close_screen
    end

    def render
      map.grid.each_with_index do |row, row_index|
        row.each_with_index do |tile, column_index|
          setpos(row_index, column_index)
          addstr(tile.to_s)
        end
      end
      refresh
    end
  end
end
