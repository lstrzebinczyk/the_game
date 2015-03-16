class TheGame
  class Item
    class Waterskin
      # assume such waterskin can hold 10 units of water/or any fluid
      # initialize it full of water
      def initialize
        @content = []
        capacity.times do
          @content << Water.new
        end
      end

      def fill_with(item)
        @content << item
      end

      def percentage
        units / capacity
      end

      def get_drink
        @content.pop
      end

      def any?
        @content.any?
      end

      def units
        @content.size
      end

      def full?
        @content.size == capacity
      end

      def capacity
        10
      end
    end
  end
end
