class TheGame
  class Action
    class LookForPlaceToSleep < Action
      def description
        "going near fireplace to sleep"
      end

      def perform(person, map, time_in_minutes)
        fire_tile = TheGame::Settlement.instance.fire_tile

        if person.distance_to(fire_tile) < 3.0
          # assume that person needs a safe place to sleep
          # for now, the only option is the fireplace

          person.action = Action::Sleep.create
        else
          person.go_to(fire_tile)
        end
      end

      private
    end
  end
end
