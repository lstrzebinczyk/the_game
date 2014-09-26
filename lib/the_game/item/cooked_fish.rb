class TheGame
  class Item
    class CookedFish
      def minutes_to_eat
        # How long can you eat a fish?
        20
      end

      def hunger_per_minute_added
        # such fish should well enough to feed for a day
        # so 20 minutes should replenish about 0.5
        # so one minute:
        0.5 / 20
      end

      def alphas
        minutes_to_eat * hunger_per_minute_added
      end

      def type
        :cooked_fish
      end
    end
  end
end
