class TheGame
  class Map
    class Generator
      def generate(size = 32)
        @size = size
        grid = new_grid(size)
        map = Map.new(grid)
        populate_with_trees(map)
        populate_with_person(map)
        map
      end

      private

      def populate_with_person(map)
        map.fetch(@size/2, @size/2) do |tile|
          tile.feature = :person
        end
      end

      def populate_with_trees(map)
        map.each_tile do |tile|
          if rand > 0.5
            tile.feature = :tree
          end
        end
      end

      def new_grid(size)
        grid = []
        size.times do
          row = []
          size.times do
            row << Map::Tile.new
          end
          grid << row
        end
        grid
      end
    end
  end
end
