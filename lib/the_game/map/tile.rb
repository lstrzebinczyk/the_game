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

        def color
          :white
        end
      end

      class Tree < Content
        def to_s
          "t"
        end

        def color
          :green
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

        def color
          :blue
        end
      end

      class Food < Content
        def initialize
          @food_count = 3
        end

        def has_food?
          true
        end

        def to_s
          "f"
        end

        def decrease_food
          @food_count -= 1
        end

        def any_food_left?
          @food_count > 0
        end

        def color
          :yellow
        end
      end

      class Fire < Content
        def passable?
          false
        end

        def to_s
          "F"
        end

        def color
          :red
        end
      end

      class Stash < Content
        attr_reader :stash

        def initialize
          @stash = TheGame::Container.new
        end

        def to_s
          "S"
        end
      end

      include TheGame::HasPosition

      attr_reader :content

      def initialize(x, y)
        @content = Null.new
        self.x = x
        self.y = y
      end

      def set_stash
        @content = Stash.new
      end

      def set_fire
        @content = Fire.new
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

      def get_food
        @content.decrease_food
        unless @content.any_food_left?
          clear
        end
      end

      def has_food?
        @content.has_food?
      end

      def update
        # if @content.is_a? Null
        #   if rand < 0.0001
        #     set_food
        #   end
        # end
      end

      def to_s
        @content.to_s
      end

      def passable?
        @content.passable?
      end

      def color
        @content.color
      end

      def impassable?
        !passable?
      end
    end
  end
end
