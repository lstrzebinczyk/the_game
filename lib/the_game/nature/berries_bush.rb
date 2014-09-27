class TheGame
  class Nature
    class BerriesBush
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y
        @berries_count = 3
      end

      def get(type)
        if type == :berries
          if @berries_count > 0
            @berries_count -= 1
            Item::Berries.new
          end
        end
      end

      def has?(type)
        if type == :berries
          !empty?
        end
      end

      def empty?
        @berries_count == 0
      end

      def description
        "berries bush"
      end
    end
  end
end
