class TheGame
  class Map
    class Tile
      class NullContent
        def type
        end

        def nil?
          true
        end

        # meaning, it does not need to be updated
        def empty?
          false
        end
      end

      include TheGame::HasPosition

      attr_accessor :content, :terrain
      attr_accessor :building

      def initialize(x, y, map)
        self.x = x
        self.y = y
        @map = map
        @content = NullContent.new
        @terrain = :ground
        @building = nil
      end

      def not_marked_for_cleaning?
        @building and @content.type
        # @building and @content
        # !(@content && @building).nil?
      end

      def clean!
        @content = NullContent.new
      end

      def description
        @terrain
      end

      def empty?
        @content.nil?
      end

      def set_river
        @terrain = :river
      end

      def update
        if @content.empty?
          case @content.type
          when :berries_bush
            clean!
            clean_event(@x, @y)
          when :tree
            @content = Nature::LogPile.new(@x, @y)
            update_event(@x, @y)
          when :log_pile
            clean!
            clean_event(@x, @y)
          else
            nil
          end
        end
      end

      private

      def clean_event(x, y)
        Map::Event.new(:clean, x, y)
      end

      def update_event(x, y)
        Map::Event.new(:update, x, y)
      end
    end
  end
end
