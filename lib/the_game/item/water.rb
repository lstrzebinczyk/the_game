class TheGame
  class Item
    class Water
      def thirst_per_minute_added
        # one water unit is 0.1 ml. 2 liters per day are needed.
        0.04
      end

      def type
        :water
      end
    end
  end
end
