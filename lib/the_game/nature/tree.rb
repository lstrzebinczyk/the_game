class TheGame
  class Nature
    class Tree
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y
      end

      def description
        "tree"
      end
    end
  end
end
