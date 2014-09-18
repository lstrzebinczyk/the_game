class TheGame
  class Map
    class Generator
      def generate(size = 32)
        @size = size
        grid = new_grid(size)
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

      def new_grid(size)
        grid = []
        size.times do |row_index|
          row = []
          size.times do |column_index|
            row << Map::Tile.new(row_index, column_index)
          end
          grid << row
        end
        grid
      end
    end
  end
end
