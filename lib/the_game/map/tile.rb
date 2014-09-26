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

        def description
          "tree"
        end
      end

      class CutTree < Content
        attr_reader :firewood_left

        def initialize
          # because why not
          @firewood_left = 60
        end

        def get(type)
          if type == :firewood
            @firewood_left -= 1
            TheGame::Item::Firewood.new
          end
        end

        def any_firewood_left?
          @firewood_left > 0
        end

        def description
          "cut tree"
        end

        def to_s
          "/"
        end

        def color
          :green
        end
      end

      class Null < Content
        def to_s
          "."
        end

        def description

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

        def description
          "food tile"
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

      include TheGame::HasPosition

      attr_reader :content

      def initialize(x, y)
        @content = Null.new
        self.x = x
        self.y = y
      end

      def description
        @content.description
      end

      def energy_per_minute_when_sleeping
        @content.energy_per_minute_when_sleeping
      end

      def add(item)
        @content.stash.add(item)
      end

      def get(type)
        @content.get(type)
      end

      def set_stash(stash)
        @content = Stash.new(stash)
      end

      def set_tree
        @content = Tree.new
      end

      def tree_cut
        @content = CutTree.new
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

      def get_firewood
        firewood = @content.get_firewood
        unless @content.any_firewood_left?
          clear
        end
        firewood
      end

      def has_tree?
        @content.is_a? Tree
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
