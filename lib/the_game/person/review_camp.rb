class TheGame
  class Person
    class ReviewCamp
      def description
        "reviewing camp..."
      end

      def perform(person, map, time_in_minutes)
        stash = map.find_stash
        person.stash_tile = stash
        person.action = WonderForNoReason.new
      end
    end
  end
end
