class TheGame
  class Construction
    class FallenTree
      include HasPosition

      attr_reader :firewood_left

      def initialize(x, y)
        @x = x
        @y = y

        # one cut tree is enough to fire a fireplace for week
        @firewood_left = 24 * 7
      end

      def get(type)
        if type == :firewood
          unless empty?
            @firewood_left -= 1
            TheGame::Item::Firewood.new
          end
        end
      end

      def empty?
        @firewood_left == 0
      end

      def description
        "cut tree"
      end
    end
  end
end
