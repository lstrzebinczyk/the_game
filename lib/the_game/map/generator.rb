class TheGame
  class Map
    class Generator
      def generate(width = 60, height = 30)
        @width  = width
        @height = height

        grid = new_grid
        map = Map.new(grid)
        create_river(map)
        populate_with_trees(map)
        populate_with_food(map)
        create_camp(map)
        map
      end

      private

      def create_camp(map)
        settlement = TheGame::Settlement.instance
        settlement.set_position(map.height / 2, map.width  / 2)

        stash_x = map.height / 2 + 2
        stash_y = map.width  / 2 + 2
        stash = TheGame::Construction::Stash.new(stash_x, stash_y)
        stash.add(TheGame::Item::Axe.new)
        stash.add(TheGame::Item::FishingRod.new)

        20.times do
          stash.add(TheGame::Item::Firewood.new)
        end

        settlement.stash = stash

        TheGame::Settlement.instance.setup
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
            tile.content = Nature::BerriesBush.new(tile.x, tile.y) unless tile.terrain == :river
          end
        end
      end

      def populate_with_trees(map)
        map.each_tile do |tile|
          if rand < 0.08
            tile.content = Nature::Tree.new(tile.x, tile.y)  unless tile.terrain == :river
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
