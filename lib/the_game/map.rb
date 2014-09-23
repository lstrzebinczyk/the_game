class TheGame
  class Map
    attr_reader :grid

    def initialize(grid)
      @grid = grid
    end

    # def stash
    #   @stash ||= find_stash.content.stash
    # end

    def fetch(width, height)
      tile = @grid[width] && @grid[width][height]
      yield(tile) if block_given?
      tile
    end

    # def find_stash
    #   find do |tile|
    #     tile.content.is_a? Tile::Stash
    #   end
    # end

    # def find_fire
    #   find do |tile|
    #     tile.content.is_a? Tile::Fire
    #   end
    # end

    def find
      each_tile do |tile|
        if yield(tile)
          return tile
        end
      end
      return nil
    end

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
  end
end
