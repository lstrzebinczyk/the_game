class TheGame
  class Map
    class Generator
      def generate
        @width  = 16 * 4
        @height = 16 * 3

        # @width  = 90
        # @height = 90

        @map = Map.new
        @map.grid = new_grid
        create_river(@map)
        populate_with_trees(@map)
        populate_with_food(@map)
        create_camp(@map)
        @map
      end

      private

      def create_camp(map)
        settlement = TheGame::Settlement.instance
        settlement_x = map.height / 2
        settlement_y = map.width  / 2

        settlement.set_position(settlement_x, settlement_y)

        fireplace = Construction::Fireplace.new(settlement_x, settlement_y)
        settlement.fireplace = fireplace
        map.fetch(settlement_x, settlement_y).building = fireplace

        stash_x = map.height / 2 + 2
        stash_y = map.width  / 2 + 2
        stash = TheGame::Construction::Stash.new(stash_x, stash_y)

        [0, 1].each do |row|
          [0, 1].each do |col|
            tile = map.fetch(stash_x + row, stash_y + col)
            tile.building = stash
          end
        end

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
            tile.content = Nature::BerriesBush.new(tile.x, tile.y) if (tile.terrain == :ground and tile.content.nil? and tile.building.nil?)
          end
        end
      end

      def populate_with_trees(map)
        map.each_tile do |tile|
          if rand < 0.08
            tile.content = Nature::Tree.new(tile.x, tile.y) if (tile.terrain == :ground and tile.content.nil? and tile.building.nil?)
          end
        end
      end

      def new_grid
        grid = []
        @height.times do |row_index|
          row = []
          @width.times do |column_index|
            row << Map::Tile.new(row_index, column_index, @map)
          end
          grid << row
        end
        grid
      end
    end
  end
end
