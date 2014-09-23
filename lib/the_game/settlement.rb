require "singleton"

class TheGame
  class Settlement
    include Singleton

    attr_accessor :stash_tile, :fire_tile

    def stash
      stash_tile.content.stash
    end
  end
end
