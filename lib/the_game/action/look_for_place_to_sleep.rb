class TheGame
  class Action
    class LookForPlaceToSleep < Action
      def description
        "going near fireplace to sleep"
      end

      def perform(person, map, time_in_minutes)
        safe_place_to_sleep = TheGame::Settlement.instance.safe_place_to_sleep

        if person.distance_to(safe_place_to_sleep) < 2.0
          # assume that person needs a safe place to sleep
          # for now, the only option is the fireplace

          person.action = Action::Sleep.create(safe_place_to_sleep)
        else
          person.go_to(safe_place_to_sleep)
        end
      end

      private
    end
  end
end
