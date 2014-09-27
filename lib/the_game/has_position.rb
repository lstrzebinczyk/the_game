class TheGame
  module HasPosition
    class Position
      # This class is used to return a position, which is related to parent position
      # like, a place near the fireplace
      # or a place inside the dormitory (so we avoid people sleeping inside the walls)


      attr_reader :x, :y

      def initialize(x, y, parent)
        @x = x
        @y = y
        @parent = parent
      end

      def method_missing(meth, *args, &block)
        @parent.send(meth, *args, &block)
      end
    end

    def x=(x)
      @x = x.to_f
    end

    def y=(y)
      @y = y.to_f
    end

    def x
      @x.to_i
    end

    def y
      @y.to_i
    end

    def close_enough_to(object)
      distance_to(object) < 2.0
    end

    def distance_to(object)
      Math.sqrt((x - object.x) ** 2 + (y - object.y) ** 2)
    end

    def position(x, y, parent)
      Position.new(x, y, parent)
    end

    def go_to(object)
      # TODO FIX THIS
      # distance   = distance_to(object)
      # x_distance = object.x - self.x
      # y_distance = object.y - self.y

      # self.x += x_distance.to_f / distance
      # self.y += y_distance.to_f / distance

      if object.x < self.x
        self.x -= 1
      elsif object.x > self.x
        self.x += 1
      end
      if object.y < self.y
        self.y -= 1
      elsif object.y > self.y
        self.y += 1
      end
    end
  end
end

