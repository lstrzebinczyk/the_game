class TheGame
  class Item
    class Food
      def minutes_to_eat
        # How long can you eat a bunch of berries?
        20
      end

      def hunger_per_minute_added
        # 60 minutes should replenish 0.5
        # so 1 minute, this:
        0.00834
      end

      def alphas
        minutes_to_eat * hunger_per_minute_added
      end
    end
  end
end
