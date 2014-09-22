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
        offset_x = rand(3) - 1
        offset_y = rand(3) - 1
        tile = map.fetch(person.x + offset_x, person.y + offset_y)

        while tile.nil? or tile.impassable?
          offset_x = rand(3) - 1
          offset_y = rand(3) - 1
          tile = map.fetch(person.x + offset_x, person.y + offset_y)
        end

        person.x += offset_x
        person.y += offset_y
      end

      def check_if_hungry(person)
        if person.hungry?
          person.action = LookForFood.new
        end
      end
    end
  end
end
