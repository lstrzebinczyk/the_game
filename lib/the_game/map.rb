require_relative "map/generator"
require_relative "map/tile"

class TheGame
  class Map
    attr_reader :grid

    def initialize(grid)
      @grid = grid
    end

    def fetch(width, height)
      tile = @grid[width][height]
      yield(tile)
    end

    def each_tile
      @grid.each do |row|
        row.each do |tile|
          yield(tile)
        end
      end
    end
  end
end
