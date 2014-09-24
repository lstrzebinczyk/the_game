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
      clear if @iteration % 50 == 0
      render_map
      render_people
      render_people_stats
      render_stash_stats
      render_settlement_stats
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
      setpos(1, map.width + 50)
      addstr("  food:     #{stash.food_count}")
      setpos(2, map.width + 50)
      addstr("  firewood: #{stash.firewood_count}")
      setpos(3, map.width + 50)
      addstr("  axes:     #{stash.axes_count}")
    end

    def render_settlement_stats
      setpos(5, map.width + 50)
      addstr("Jobs: ")

      jobs_count = TheGame::Settlement.instance.jobs_count

      setpos(6, map.width + 50)
      addstr("  haul:        #{jobs_count[:haul]}")
      setpos(7, map.width + 50)
      addstr("  management:  #{jobs_count[:management]}")
      setpos(8, map.width + 50)
      addstr("  woodcutting: #{jobs_count[:woodcutting]}")
      setpos(9, map.width + 50)
      addstr("  gatherer:    #{jobs_count[:gatherer]}")

      setpos(11, map.width + 50)
      addstr("Fire: ")
      setpos(12, map.width + 50)
      addstr " " * 50
      setpos(13, map.width + 50)
      addstr("  minutes left: #{TheGame::Settlement.instance.minutes_left_for_fire}")
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
        addstr("Person (#{person.type}) stats:")

        setpos(3 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(3 + 5 * index, map.width + 2)
        addstr("  hunger: #{progress_bar(person.hunger)}")

        setpos(4 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(4 + 5 * index, map.width + 2)
        addstr("  energy: #{progress_bar(person.energy)}")

        setpos(5 + 5 * index, map.width + 2)
        addstr " " * 50
        setpos(5 + 5 * index, map.width + 2)
        addstr("  action: #{person.action.description}")
      end
    end

    private

    def progress_bar(value)
      #TODO: Make sure person attributes are always in proper range

      progress_bar_size = 30

      if value < 0
        proper_value = 0.0
      elsif value > 1
        proper_value = 1.0
      else
        proper_value = value
      end

      progress_bar_return = "|"

      n = (proper_value * progress_bar_size).to_i

      n.times do
        progress_bar_return += "="
      end

      (progress_bar_size - n).times do
        progress_bar_return += " "
      end

      progress_bar_return += "|"
      progress_bar_return
    end
  end
end
