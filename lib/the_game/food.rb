class TheGame
  class Food
    def minutes_to_eat
      60
    end

    def hunger_per_minute_added
      6 * 0.0002314814814814815
    end

    def alphas
      minutes_to_eat * hunger_per_minute_added
    end
  end
end
