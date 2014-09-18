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
      # crmode
    end

    def close
      close_screen

    end

    def render
      crmode

      # clear

      map.grid.each_with_index do |row, row_index|
        row.each_with_index do |tile, column_index|
          setpos(row_index, column_index)
          addstr(pixel(tile))
        end
      end
      refresh
      # getch
      sleep(0.2)


      # init_screen
      # begin
      #   crmode
      #   # addstr("Hit any key")
      #   # refresh

      #   while true
      #     # yield #@engine.update

      #     map.grid.each_with_index do |row, row_index|
      #       row.each_with_index do |tile, column_index|
      #         setpos(row_index, column_index)
      #         addstr(pixel(tile))
      #         # flush << pixel(tile)
      #       end
      #       # flush << "\n"
      #     end
      #     refresh
      #   end


      #   # getch
      #   # show_message("hello world!")
      # ensure
      #   close_screen
      # end
      # # flush = ""

      # # # flush
      # # puts flush
    end

    private

    def pixel(tile)
      case tile.feature
      when nil
        "."
      when :tree
        "x"
      when :person
        "P"
      end
    end
  end
end
