class TheGame
  class Window
    include Curses

    def initialize(engine)
      @engine = engine
      @iteration = 0
    end

    def map
      @engine.map
    end

    def people
      @engine.people
    end

    def stash
      TheGame::Settlement.instance.stash
    end

    def time
      @engine.time.strftime("%H:%M %S")
    end

    def init
      Curses.start_color
      Curses.init_pair(COLOR_BLUE,COLOR_BLUE,COLOR_BLACK)
      Curses.init_pair(COLOR_YELLOW,COLOR_YELLOW,COLOR_BLACK)
      Curses.init_pair(COLOR_GREEN,COLOR_GREEN,COLOR_BLACK)
      Curses.init_pair(COLOR_RED,COLOR_RED,COLOR_BLACK)
      init_screen
    end

    def close
      close_screen
    end

    def render
      clear if @iteration % 200 == 0
      render_map
      render_people
      render_people_stats
      render_stash_stats
      render_time

      refresh
      @iteration += 1
    end

    private

    def render_map
      map.grid.each_with_index do |row, row_index|
        row.each_with_index do |tile, column_index|
          setpos(row_index, column_index)

          if tile.color == :blue
            Curses.attron(color_pair(COLOR_BLUE)|A_NORMAL) {
              addstr(tile.to_s)
            }
          elsif tile.color == :yellow
            Curses.attron(color_pair(COLOR_YELLOW)|A_NORMAL) {
              addstr(tile.to_s)
            }
          elsif tile.color == :green
            Curses.attron(color_pair(COLOR_GREEN)|A_NORMAL) {
              addstr(tile.to_s)
            }
          elsif tile.color == :red
            Curses.attron(color_pair(COLOR_RED)|A_NORMAL) {
              addstr(tile.to_s)
            }
          else
            addstr(tile.to_s)
          end
        end
      end
    end

    def render_people
      people.each do |person|
        setpos(person.x, person.y)
        addstr(person.to_s)
      end
    end

    def render_time
      setpos(0, map.width + 15)

      addstr("Time: #{time}")
    end

    def render_stash_stats
      setpos(0, map.width + 50)
      addstr("Stash: ")
      setpos(3, map.width + 50)
      addstr("  food: #{stash.food_count}")
    end

    def render_people_stats
      setpos(0, map.width + 2)
      addstr " " * 50
      setpos(0, map.width + 2)
      addstr("Alive: #{people.size}")

      people.each_with_index do |person, index|
        setpos(2 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(2 + 5 * index, map.width + 2)
        addstr("Person stats:")

        setpos(3 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(3 + 5 * index, map.width + 2)
        addstr("  hunger: #{person.hunger}")

        setpos(4 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(4 + 5 * index, map.width + 2)
        addstr("  energy: #{person.energy}")

        setpos(5 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(5 + 5 * index, map.width + 2)
        addstr("  action: #{person.action.description}")
      end
    end
  end
end
