class TheGame
  class Person
    class Eat
      def initialize(food)
        @food = food
        @turns_spent_eating_left = @food.turns_to_eat
      end

      def description
        "eating"
      end

      def perform(person, map)
        @turns_spent_eating_left -= 1
        person.hunger += @food.hunger_per_turn_added

        if @turns_spent_eating_left == 0
          person.action = WonderForNoReason.new
        end
      end
    end
  end
end
