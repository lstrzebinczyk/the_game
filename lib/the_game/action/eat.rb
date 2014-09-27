class TheGame
  class Action
    class Eat < Action
      def initialize(food)
        @food = food
        @seconds_spent_eating_left = @food.seconds_to_eat
      end

      def description
        "eating #{@food.type}"
      end

      def perform(person, map, time_in_seconds)
        @seconds_spent_eating_left -= time_in_seconds
        person.hunger += @food.hunger_per_second_added * time_in_seconds

        if @seconds_spent_eating_left == 0
          person.do_stuff
        end
      end
    end
  end
end
