class TheGame
  class Construction
    class Fireplace
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y

        @seconds_left_for_fire = 4 * 60 * 60 # 4 hours
      end

      def sleep_area
        x_offset = [-2, -1, 0, 1, 2].sample
        y_offset = [-2, -1, 0, 1, 2].sample

        # so we avoid people sleeping inside the fireplace
        while(x_offset == 0 and y_offset == 0)
          x_offset = [-2, -1, 0, 1, 2].sample
          y_offset = [-2, -1, 0, 1, 2].sample
        end

        position(x + x_offset, y + y_offset, self)
      end

      def update(seconds)
        @seconds_left_for_fire -= seconds
      end

      def minutes_left_for_fire
        @seconds_left_for_fire / 60
      end

      def add_firewood_to_fire(firewood)
        @seconds_left_for_fire += firewood.amount * 60
      end

      def fire_is_ok?
        @seconds_left_for_fire / 60 > 4 * 60
      end

      def description
        "fireplace"
      end

      def energy_per_second_when_sleeping
        # this will be ok for a sleep in sort-of-good conditions
        # 3 * 0.00104167

        # sleeping on floor is way less refreshing
        # 2.3 * 0.00104167 this is per minute
        2.3 * 0.00104167 / 60
      end
    end
  end
end
