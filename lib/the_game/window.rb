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
      clear if @iteration % 500 == 0
      render_map
      render_settlement
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

          if tile.marked_for_cleaning?
            Curses.attron(color_pair(COLOR_RED)|A_NORMAL) {
              if tile.content.is_a? Nature::Tree
                addstr("t")
              elsif tile.content.is_a? Construction::FallenTree
                addstr("/")
              else
                addstr(tile.to_s)
              end
            }
          elsif tile.content.is_a? Nature::Tree
            Curses.attron(color_pair(COLOR_GREEN)|A_NORMAL) {
              addstr("t")
            }
          elsif tile.content.is_a? Construction::FallenTree
            Curses.attron(color_pair(COLOR_GREEN)|A_NORMAL) {
              addstr("/")
            }
          elsif tile.terrain == :river
            Curses.attron(color_pair(COLOR_BLUE)|A_NORMAL) {
              addstr(["~", " "].sample)
            }
          elsif tile.content.nil?
            addstr(".")
          elsif tile.color == :blue
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

    def render_settlement
      #render fireplace

      fireplace = Settlement::instance.fireplace
      setpos(fireplace.x, fireplace.y)
      add_string("F", :red)

      dormitory = TheGame::Settlement.instance.dormitory
      if dormitory and dormitory.status != :cleaning
        print_dormitory(dormitory)
      end

      stash = Settlement::instance.stash
      setpos(stash.x, stash.y)
      add_string("S")

      # Settlement.instance.fallen_trees.each do |tree|
      #   setpos(tree.x, tree.y)
      #   add_string("/", :green)
      # end
    end

    def print_dormitory(dormitory)
      dormitory_print = """
      XXXX
      X  X
      X  X
      X  X
      """

      x = dormitory.x
      y = dormitory.y

      if dormitory.status == :done
        color = :white
      else
        color = :blue
      end

      setpos(x, y)
      add_string("X", color)

      setpos(x, y + 1)
      add_string("X", color)

      setpos(x, y + 2)
      add_string("X", color)

      setpos(x, y + 3)
      add_string("X", color)

      setpos(x + 1, y)
      add_string("X", color)

      setpos(x + 1, y + 1)
      add_string(" ", color)

      setpos(x + 1, y + 2)
      add_string(" ", color)

      setpos(x + 1, y + 3)
      add_string("X", color)

      setpos(x + 2, y)
      add_string("X", color)

      setpos(x + 2, y + 1)
      add_string(" ", color)

      setpos(x + 2, y + 2)
      add_string(" ", color)

      setpos(x + 2, y + 3)
      add_string("X", color)

      setpos(x + 3, y)
      add_string("X", color)

      setpos(x + 3, y + 1)
      add_string(" ", color)

      setpos(x + 3, y + 2)
      add_string(" ", color)

      setpos(x + 3, y + 3)
      add_string("X", color)
    end

    def add_string(string, color = :white)
      if color == :blue
        Curses.attron(color_pair(COLOR_BLUE)|A_NORMAL) {
          addstr(string)
        }
      elsif color == :red
        Curses.attron(color_pair(COLOR_RED)|A_NORMAL) {
          addstr(string)
        }
      elsif color == :green
        Curses.attron(color_pair(COLOR_GREEN)|A_NORMAL) {
          addstr(string)
        }
      else
        Curses.attron(color_pair(A_NORMAL)|A_NORMAL) {
          addstr(string)
        }
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
      addstr("  berries:      #{stash.count(:berries)}")
      setpos(2, map.width + 50)
      addstr("  fish:         #{stash.count(:fish)}")
      setpos(3, map.width + 50)
      addstr("  cooked_fish:  #{stash.count(:cooked_fish)}")
      setpos(4, map.width + 50)
      addstr("  firewood:     #{stash.count(:firewood)}")
      setpos(5, map.width + 50)
      addstr("  axes:         #{stash.count(:axe)}")
      setpos(6, map.width + 50)
      addstr("  fishing_rods: #{stash.count(:fishing_rod)}")
    end

    def render_settlement_stats
      setpos(11, map.width + 50)
      addstr("Fire: ")
      setpos(12, map.width + 50)
      addstr " " * 50
      setpos(12, map.width + 50)
      addstr("  minutes left: #{TheGame::Settlement.instance.fireplace.minutes_left_for_fire}")

      dormitory = Settlement.instance.dormitory

      if dormitory
        setpos(14, map.width + 50)
        addstr("Buildings:")
        setpos(15, map.width + 50)
        addstr("  Dormitory:")
        setpos(16, map.width + 50)
        addstr("    status:          #{dormitory.status}")
        if dormitory.status == :plan
          setpos(17, map.width + 50)
          addstr("    firewood needed: #{dormitory.firewood_needed}")
        elsif dormitory.status == :building
          setpos(17, map.width + 50)
          addstr("    construction left: #{dormitory.minutes_left}")
        end
      end
    end

    def render_people_stats
      setpos(0, map.width + 2)
      addstr " " * 50
      setpos(0, map.width + 2)
      addstr("Alive: #{people.size}")

      people.each_with_index do |person, index|
        setpos(2 + 6 * index, map.width + 2)
        addstr " " * 50
        setpos(2 + 6 * index, map.width + 2)
        addstr("Person (#{person.type}) stats:")

        setpos(3 + 6 * index, map.width + 2)
        addstr " " * 50
        setpos(3 + 6 * index, map.width + 2)
        addstr("  thirst: #{progress_bar(person.thirst)}")

        setpos(4 + 6 * index, map.width + 2)
        addstr " " * 50
        setpos(4 + 6 * index, map.width + 2)
        addstr("  hunger: #{progress_bar(person.hunger)}")

        setpos(5 + 6 * index, map.width + 2)
        addstr " " * 50
        setpos(5 + 6 * index, map.width + 2)
        addstr("  energy: #{progress_bar(person.energy)}")

        setpos(6 + 6 * index, map.width + 2)
        addstr " " * 50
        setpos(6 + 6 * index, map.width + 2)
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
