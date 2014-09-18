class TheGame
  class Person
    class WonderForNoReason
      def description
        "just wondering"
      end

      def perform(person, map)
        move_around(person, map)
        check_if_hungry(person)
      end

      private

      def move_around(person, map)
        person.x += (rand(3) - 1)
        person.y += (rand(3) - 1)

        if person.x < 0
          person.x = 0
        end
        if person.x > map.size - 1
          person.x = map.size - 1
        end
        if person.y < 0
          person.y = 0
        end
        if person.y > map.size - 1
          person.y = map.size - 1
        end
      end

      def check_if_hungry(person)
        if person.hungry?
          person.action = LookForFood.new
        end
      end
    end
  end
end
