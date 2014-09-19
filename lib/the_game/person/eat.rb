class TheGame
  class Person
    class Eat
      def initialize
        @turns_spent_eating = 0
      end

      def description
        "eating"
      end

      def perform(person, map)
        @turns_spent_eating += 1
        person.hunger += 0.20

        if @turns_spent_eating == 3
          person.action = WonderForNoReason.new
        end
      end
    end
  end
end
