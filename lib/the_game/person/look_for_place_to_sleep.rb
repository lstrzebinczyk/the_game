class TheGame
  class Person
    class LookForPlaceToSleep
      def description
        "going near fireplace to sleep"
      end

      def perform(person, map, time_in_minutes)
        if person.is_standing_near_fireplace?
          # assume that person needs a safe place to sleep
          # for now, the only option is the fireplace

          person.action = Sleep.new
        else
          person.go_to(person.fire_tile)
        end
      end

      private
    end
  end
end
