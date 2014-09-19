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

    def people
      @engine.people
    end

    def init
      init_screen
    end

    def close
      close_screen
    end

    def render
      clear
      render_map
      render_people
      render_people_stats

      refresh
    end

    private

    def render_map
      map.grid.each_with_index do |row, row_index|
        row.each_with_index do |tile, column_index|
          setpos(row_index, column_index)
          addstr(tile.to_s)
        end
      end
    end

    def render_people
      people.each do |person|
        setpos(person.x, person.y)
        addstr(person.to_s)
      end
    end

    def render_people_stats
      setpos(0, map.width + 2)
      addstr " " * 50
      setpos(0, map.width + 2)
      addstr("Alive: #{people.size}")

      people.each_with_index do |person, index|
        setpos(2 + 4 * index, map.width + 2)
        addstr " " * 50
        setpos(2 + 4 * index, map.width + 2)
        addstr("Person stats:")
        setpos(3 + 4 * index, map.width + 2)
        addstr " " * 50
        setpos(3 + 4 * index, map.width + 2)
        addstr("  hunger: #{person.hunger}")
        setpos(4 + 4 * index, map.width + 2)
        addstr " " * 50
        setpos(4 + 4 * index, map.width + 2)
        addstr("  action: #{person.action.description}")
      end
    end
  end
end
