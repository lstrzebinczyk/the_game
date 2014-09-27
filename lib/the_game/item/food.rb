class TheGame
  class Item
    class Food
      def seconds_to_eat
        # How long can you eat a bunch of berries?
        10 * 60
      end

      def hunger_per_second_added
        # 60 minutes should replenish 0.2
        # so 1 minute, this:
        # 0.00834
        0.2 / seconds_to_eat
      end

      def alphas
        seconds_to_eat * hunger_per_second_added
      end

      def type
        :food
      end
    end
  end
end
