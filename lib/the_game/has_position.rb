class TheGame
  module HasPosition
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

    def distance_to(object)
      Math.sqrt((x - object.x) ** 2 + (y - object.y) ** 2)
    end

    def go_to(object)
      distance   = distance_to(object)
      x_distance = object.x - self.x
      y_distance = object.y - self.y

      self.x += x_distance / distance
      self.y += y_distance / distance
    end
  end
end
