class TheGame
  class Map
    class Event
      attr_reader :type, :x, :y

      def initialize(type, x, y, opts = {})
        @type = type
        @x = x
        @y = y
        @opts = opts
      end
    end
  end
end
