class TheGame
  class Person
    class ReviewCamp
      def description
        "reviewing camp..."
      end

      def perform(person, map, time_in_minutes)
        stash = map.find_stash
        person.stash_tile = stash

        fire = map.find_fire
        person.fire_tile = fire

        person.action = WonderForNoReason.new
      end
    end
  end
end
