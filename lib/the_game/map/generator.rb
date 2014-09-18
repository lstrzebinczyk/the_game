class TheGame
  class Map
    class Generator
      def generate(width = 120, height = 30)
        @width  = width
        @height = height

        grid = new_grid
        map = Map.new(grid)
        populate_with_food(map)
        map
      end

      private

      def populate_with_food(map)
        map.each_tile do |tile|
          if rand > 0.8
            tile.set_food
          end
        end
      end

      def new_grid
        grid = []
        @height.times do |row_index|
          row = []
          @width.times do |column_index|
            row << Map::Tile.new(row_index, column_index)
          end
          grid << row
        end
        grid
      end
    end
  end
end
