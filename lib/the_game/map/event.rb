class TheGame
  class Map
    class Event
      attr_reader :type, :x, :y

      def initialize(type, x, y)
        @type = type
        @x = x
        @y = y
      end
    end
  end
end
