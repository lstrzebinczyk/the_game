class TheGame
  class Construction
    class Fireplace
      include HasPosition

      def initialize(x, y)
        @x = x
        @y = y

        @minutes_left_for_fire = Countdown.new(4 * 60)
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

      def update(minutes)
        @minutes_left_for_fire.add_minutes(minutes)
      end

      def minutes_left_for_fire
        @minutes_left_for_fire.to_i
      end

      def add_firewood_to_fire(firewood)
        @minutes_left_for_fire.add_minutes(-firewood.amount)
      end

      def fire_is_ok?
        @minutes_left_for_fire.to_i > 4 * 60
      end

      def description
        "fireplace"
      end

      def energy_per_minute_when_sleeping
        # this will be ok for a sleep in sort-of-good conditions
        # 3 * 0.00104167

        # sleeping on floor is way less refreshing
        2.3 * 0.00104167
      end
    end
  end
end
