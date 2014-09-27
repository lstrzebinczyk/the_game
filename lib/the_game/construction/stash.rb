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
    end
  end
end
