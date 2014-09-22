class TheGame
  class Map
    class Tile
      class Content
        def has_food?
          false
        end

        def passable?
          true
        end
      end

      class Tree < Content
        def to_s
          "x"
        end
      end

      class Null < Content
        def to_s
          "."
        end
      end

      class River < Content
        def passable?
          false
        end

        def to_s
          ["~", " "].sample
        end
      end

      class Food < Content
        def has_food?
          true
        end

        def to_s
          "f"
        end
      end

      include TheGame::HasPosition

      def initialize(x, y)
        @content = Null.new
        self.x = x
        self.y = y
      end

      def set_tree
        @content = Tree.new
      end

      def set_food
        @content = Food.new
      end

      def set_river
        @content = River.new
      end

      def clear
        @content = Null.new
      end

      def has_food?
        @content.has_food?
      end

      def update
        if @content.is_a? Null
          if rand < 0.0001
            set_food
          end
        end
      end

      def to_s
        @content.to_s
      end

      def passable?
        @content.passable?
      end

      def impassable?
        !passable?
      end
    end
  end
end
