class TheGame
  class Person
    class WonderForNoReason
      def description
        "just wondering"
      end

      def perform(person, map, time_in_minutes)
        move_around(person, map)

        if person.hungry?
          person.action = LookForFood.new
        elsif person.sleepy?
          person.action = LookForPlaceToSleep.new
        elsif person.will_take_jobs
          person.action = LookForFoodToHarvest.new
        end
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
    end
  end
end
