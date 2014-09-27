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

      class Food < Content
        def initialize
          @food_count = 3
        end

        def has_food?
          true
        end

        def description
          "berries tile"
        end

        def to_s
          "#"
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

      attr_accessor :content, :terrain

      def initialize(x, y)
        # @content = Null.new
        self.x = x
        self.y = y
      end

      def mark_for_cleaning!
        @mark_for_cleaning = true unless empty?
      end

      def cleaned!
        @mark_for_cleaning = false
      end

      def marked_for_cleaning?
        @mark_for_cleaning == true
      end

      def description
        if @content
          @content.description
        end
      end

      def get(type)
        @content.get(type)
      end

      def empty?
        @content.nil?
      end

      def set_food
        @content = Food.new
      end

      def set_river
        @terrain = :river
        # @content = River.new
      end

      def update
        if @content.is_a? Construction::FallenTree and @content.empty?
          @content = nil
        end

      end

      def clear
        # @mark_for_cleaning = false
        @content = nil
      end

      def get_food
        @content.decrease_food
        unless @content.any_food_left?
          clear
          cleaned!
        end
      end

      def has_food?
        @content.is_a? Food
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
