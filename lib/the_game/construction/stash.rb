require 'the_game/container'
require 'the_game/has_position'

class TheGame
  class Construction
    class Stash < Container
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y
        super()
      end

      def description
        "stash"
      end

      def need?(item_type)
        true
      end

      def tiles_coords
        [
          [0, 0], [0, 1],
          [1, 0], [1, 1]
        ]
      end
    end
  end
end
