class TheGame
  class Item
    class Food
      def minutes_to_eat
        # How long can you eat a bunch of berries?
        10
      end

      def hunger_per_minute_added
        # 60 minutes should replenish 0.2
        # so 1 minute, this:
        # 0.00834
        0.2 / minutes_to_eat
      end

      def alphas
        minutes_to_eat * hunger_per_minute_added
      end

      def type
        :food
      end
    end
  end
end
