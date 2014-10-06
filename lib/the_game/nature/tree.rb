class TheGame
  class Nature
    class Tree
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y
      end

      def cut!
        @cut = true
      end

      def cut?
        @cut
      end

      def empty?
        cut?
      end

      def description
        "tree"
      end

      def type
        :tree
      end
    end
  end
end
