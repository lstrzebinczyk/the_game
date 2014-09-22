class TheGame
  class Person
    class Eat
      def initialize(food)
        @food = food
        @minutes_spent_eating_left = @food.minutes_to_eat
      end

      def description
        "eating"
      end

      def perform(person, map, time_in_minutes)
        @minutes_spent_eating_left -= time_in_minutes
        person.hunger += @food.hunger_per_minute_added * time_in_minutes

        if @minutes_spent_eating_left == 0
          if person.full?
            person.action = WonderForNoReason.new
          else
            person.action = LookForFood.new
          end
        end
      end
    end
  end
end
