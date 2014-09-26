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
    end
  end
end
