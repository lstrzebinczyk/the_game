class TheGame
  class Map
    attr_reader :grid

    def initialize(grid)
      @grid = grid
    end

    def fetch(width, height)
      tile = @grid[width] && @grid[width][height]
      yield(tile) if block_given?
      tile
    end

    def find_closest_to(person)
      closest = find {|tile| tile.has_food? }

      if closest
        each_tile do |tile|
          if yield(tile)
            if person.distance_to(tile) < person.distance_to(closest)
              closest = tile
            end
          end
        end
      end

      closest
    end

    # def firewood_lying_around
    #   result = 0

    #   each_tile do |tile|
    #     if tile.content.is_a? TheGame::Map::Tile::CutTree
    #       result += tile.content.firewood_left
    #     end
    #   end

    #   result
    # end

    def update
      each_tile do |tile|
        tile.update
      end
    end

    def width
      @grid.first.length
    end

    def height
      @grid.length
    end

    def each_tile
      @grid.each do |row|
        row.each do |tile|
          yield(tile)
        end
      end
    end

    private

    def find
      each_tile do |tile|
        if yield(tile)
          return tile
        end
      end
      return nil
    end

  end
end
