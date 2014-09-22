class TheGame
  class Map
    class Generator
      def generate(width = 120, height = 30)
        @width  = width
        @height = height

        grid = new_grid
        map = Map.new(grid)
        populate_with_trees(map)
        populate_with_food(map)
        create_camp(map)
        create_river(map)
        map
      end

      private

      def create_camp(map)
        stash_x = map.height / 2 + 2
        stash_y = map.width  / 2 + 2

        map.fetch(stash_x, stash_y) do |tile|
          tile.set_stash
        end
      end

      def create_river(map)
        map.each_tile do |tile|
          if tile.x > 4 && tile.x < 9
            tile.set_river
          end
        end
      end

      def populate_with_food(map)
        map.each_tile do |tile|
          if rand < 0.12
            tile.set_food
          end
        end
      end

      def populate_with_trees(map)
        map.each_tile do |tile|
          if rand < 0.08
            tile.set_tree
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
